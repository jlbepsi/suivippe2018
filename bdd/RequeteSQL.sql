
-- Suppression d'un utilisateur


CREATE PROCEDURE removeUtilisateur(IN login VARCHAR(50))
BEGIN
    -- Suppression

--
-- SITUATION
--
DELETE FROM activitecitee
WHERE refSituation IN (SELECT reference FROM situation WHERE login = pLogin);

DELETE FROM commentaire
WHERE refSituation IN (SELECT reference FROM situation WHERE login = pLogin);

DELETE FROM situationtypo
WHERE reference IN (SELECT reference FROM situation WHERE login = pLogin);

DELETE FROM situation
WHERE login = pLogin;

DELETE FROM situatione4
WHERE referencee4 IN (SELECT reference FROM situation WHERE login = pLogin);

--
-- STAGE
--
DELETE FROM stageintituleactivite
WHERE idStage IN (SELECT id FROM stage WHERE login = pLogin);

DELETE FROM stageintitule
WHERE idStage IN (SELECT id FROM stage WHERE login = pLogin);

DELETE FROM stagetypo
WHERE idStage IN (SELECT id FROM stage WHERE login = pLogin);

DELETE FROM stage
WHERE id = pLogin;

	--
	-- UTILISATEUR
	--
	DELETE FROM utilisateur
	WHERE login = pLogin;
END

