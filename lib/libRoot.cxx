
////////////////////////////////////////////////////////////////////////////////
// C interface
////////////////////////////////////////////////////////////////////////////////

extern "C" {
    void       setBatch(bool on);

    // TFile
    void * newTFile(const char * name, const char * option);
    void   deleteTFile(void * file);

    // TChain
    void *     newTChain(const char * name);
    void       chainAdd(void * chain, const char * rootFilePattern);
    void       deleteChain(void * chain);
    long long  chainDraw(void * chain, const char * expression, const char * selection, const char * option);
    long long  chainGetEntries(void * chain);

    // TH1D
    void *  newTH1D(const char * name, const char * title, int nBinsX, double xMin, double xMax);
    void *  newTH1D_varBins(const char * name, const char * title, int nBinsX, double * xBins);
    void    deleteTH1D(void * histo);
    double  histoIntegralAndError(void * histo, int binX1, int binX2, double * err);
}


////////////////////////////////////////////////////////////////////////////////
// C++ implementation
////////////////////////////////////////////////////////////////////////////////

#include "TROOT.h"
#include "TFile.h"
#include "TChain.h"
#include "TH1D.h"

void setBatch(bool on) {
    gROOT->SetBatch(on);
}

// TFile
void * newTFile(const char * name, const char * option) {
    TFile * f = new TFile {name, option};
    return static_cast<void *>(f);
}

void deleteTFile(void * file) {
    TFile * f = static_cast<TFile *>(file);
    delete f;
}

// TChain
void * newTChain(const char * name) {
    TChain * c = new TChain {name};
    return static_cast<void *>(c);
}

void chainAdd(void * chain, const char * rootFilePattern) {
    TChain * c = static_cast<TChain *>(chain);
    c->Add(rootFilePattern);
}

void deleteChain(void * chain) {
    TChain * c = static_cast<TChain *>(chain);
    delete c;
}

long long chainDraw(void * chain, const char * expression, const char * selection, const char * option) {
    TChain * c = static_cast<TChain *>(chain);
    return c->Draw(expression, selection, option);
}

long long chainGetEntries(void * chain) {
    return static_cast<TChain *>(chain)->GetEntries();
}

// TH1D
void * newTH1D(const char * name, const char * title, int nBinsX, double xMin, double xMax) {
    TH1D * h = new TH1D {name, title, nBinsX, xMin, xMax};
    h->Sumw2();
    return static_cast<void *>(h);
}

void *  newTH1D_varBins(const char * name, const char * title, int nBinsX, double * xBins) {
    TH1D * h = new TH1D {name, title, nBinsX, xBins};
    h->Sumw2();
    return static_cast<void *>(h);
}

void deleteTH1D(void * histo) {
    TH1D * h = static_cast<TH1D *>(histo);
    delete h;
}

double histoIntegralAndError(void * histo, int binX1, int binX2, double * err) {
    TH1D * h = static_cast<TH1D *>(histo);
    return h->IntegralAndError(binX1, binX2, *err);
}

