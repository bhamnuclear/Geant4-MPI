//
// ********************************************************************
// * License and Disclaimer                                           *
// *                                                                  *
// * The  Geant4 software  is  copyright of the Copyright Holders  of *
// * the Geant4 Collaboration.  It is provided  under  the terms  and *
// * conditions of the Geant4 Software License,  included in the file *
// * LICENSE and available at  http://cern.ch/geant4/license .  These *
// * include a list of copyright holders.                             *
// *                                                                  *
// * Neither the authors of this software system, nor their employing *
// * institutes,nor the agencies providing financial support for this *
// * work  make  any representation or  warranty, express or implied, *
// * regarding  this  software system or assume any liability for its *
// * use.  Please see the license in the file  LICENSE  and URL above *
// * for the full disclaimer and the limitation of liability.         *
// *                                                                  *
// * This  code  implementation is the result of  the  scientific and *
// * technical work of the GEANT4 collaboration.                      *
// * By using,  copying,  modifying or  distributing the software (or *
// * any work based  on the software)  you  agree  to acknowledge its *
// * use  in  resulting  scientific  publications,  and indicate your *
// * acceptance of all terms of the Geant4 Software license.          *
// ********************************************************************
/// @file G4MPIsession.hh
/// @brief A terminal session for MPI application

#ifndef G4MPI_SESSION_H
#define G4MPI_SESSION_H

#include "G4VMPIsession.hh"

class G4MPIsession : public G4VMPIsession
{
  public:
    G4MPIsession(G4VUIshell* ashell = 0);
    ~G4MPIsession();

    void SetPrompt(const G4String& prompt);
    void SetShell(G4VUIshell* ashell);

    virtual G4UIsession* SessionStart();

  private:
    G4VUIshell* shell_;

    // get command from user prompt of the master node
    G4String GetCommand(const char* msg = 0);

    G4bool TryForcedTerminate();
};

#endif
