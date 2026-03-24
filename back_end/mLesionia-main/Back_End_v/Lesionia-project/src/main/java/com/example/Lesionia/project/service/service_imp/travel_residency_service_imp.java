package com.example.Lesionia.project.service.service_imp;

import com.example.Lesionia.project.domain.travel_residency;
import com.example.Lesionia.project.repo.travel_residency_repo;
import com.example.Lesionia.project.service.service_interface.travel_residency_service;
import lombok.RequiredArgsConstructor; // Assurez-vous d'avoir l'importation Lombok
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.sql.Date;
import java.util.List;
import java.util.Optional; // Importez Optional pour findById

@Service
@RequiredArgsConstructor // <-- CORRECTION : 'RequiredArgsConstructor' au lieu de 'RequiredAgsConstructor'
@Transactional
@Slf4j
public class travel_residency_service_imp implements travel_residency_service {

    // Le constructeur est généré automatiquement par @RequiredArgsConstructor
    private final travel_residency_repo travel_residency_repo;


    // Votre méthode save (conservée)
    public travel_residency save(travel_residency travel_residency) {
        if (travel_residency.getPATIENTIDENTIFIER() == null) {
            throw new IllegalArgumentException("PATIENTIDENTIFIER cannot be null");
        }
        return travel_residency_repo.save(travel_residency);
    }


    public int size(String PATIENTIDENTIFIER) {
        return get_all(PATIENTIDENTIFIER).size() + 1;
    }

    @Override
    public travel_residency get_one(String IDMVT) {
        // Remplacez findByIDMVT par findById si IDMVT est l'ID, car findById est standard.
        // Si findByIDMVT est une méthode personnalisée dans votre Repository, conservez-la.
        Optional<travel_residency> result = travel_residency_repo.findById(IDMVT);
        return result.orElse(null); // Gérer le cas où l'entité n'est pas trouvée
    }

    @Override
    public List<travel_residency> get_all(String PATIENTIDENTIFIER) {
        // Assurez-vous que get_all(String) est bien défini dans travel_residency_repo
        return travel_residency_repo.get_all(PATIENTIDENTIFIER);
    }

    @Override
    public List<travel_residency> get_travels() {
        return travel_residency_repo.findAll();
    }

    /**
     * CORRECTION CRITIQUE DE LA LOGIQUE DE MISE À JOUR :
     * Récupère l'entité existante, met à jour les champs, puis sauvegarde.
     */
    @Override
    @Transactional
    public travel_residency update_tr(travel_residency updatedResidency) {

        String IDMVT = updatedResidency.getIDMVT();

        if (IDMVT == null || IDMVT.trim().isEmpty()) {
            throw new IllegalArgumentException("The IDMVT identifier is required for update and cannot be null or empty.");
        }

        // 1. Récupérer l'entité existante
        travel_residency existingResidency = travel_residency_repo.findById(IDMVT)
                .orElseThrow(() -> new EntityNotFoundException("Travel Residency with ID " + IDMVT + " not found. Cannot update."));

        // 2. Mettre à jour les champs (ajoutez des checks pour éviter d'écraser avec nulls)
        if (updatedResidency.getFROMDATE() != null) {
            existingResidency.setFROMDATE(updatedResidency.getFROMDATE());
        }
        if (updatedResidency.getTODATE() != null) {
            existingResidency.setTODATE(updatedResidency.getTODATE());
        }
        if (updatedResidency.getRESIDENCY() != null) {
            existingResidency.setRESIDENCY(updatedResidency.getRESIDENCY());
        }
        if (updatedResidency.getTYPE() != null) {
            existingResidency.setTYPE(updatedResidency.getTYPE());
        }
        if (updatedResidency.getBYTENOT() != null) {
            existingResidency.setBYTENOT(updatedResidency.getBYTENOT());
        }
        if (updatedResidency.getCITY() != null) {
            existingResidency.setCITY(updatedResidency.getCITY());
        }

        // Les champs PATIENTIDENTIFIER et LOGINUSER doivent être persistés pour la mise à jour (souvent non modifiables)
        if (updatedResidency.getPATIENTIDENTIFIER() != null) {
            existingResidency.setPATIENTIDENTIFIER(updatedResidency.getPATIENTIDENTIFIER());
        }

        // 3. Sauvegarder l'entité existante (UPDATE)
        return travel_residency_repo.save(existingResidency);
    }


    @Override
    public int get_alltravelsbyid(String LOGINUSER) {
        return travel_residency_repo.get_alltravelsbyid(LOGINUSER);
    }
}