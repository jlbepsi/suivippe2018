
-- Suppression d'un utilisateur

DEFINE @userToRemove VARCHAR (50)

SET @userToRemove = '';


--
-- SITUATION
--


DELETE FROM activitecitee
WHERE refSituation IN (SELECT reference FROM situation WHERE login = @userToRemove)


DELETE FROM commentaire
WHERE refSituation IN (SELECT reference FROM situation WHERE login = @userToRemove)


DELETE FROM situatione4
WHERE referencee4 IN (SELECT reference FROM situation WHERE login = @userToRemove)


DELETE FROM situationtypo
WHERE reference IN (SELECT reference FROM situation WHERE login = @userToRemove)

DELETE FROM situation
WHERE login = @userToRemove


--
-- STAGE
--

DELETE FROM stageintituleactivite
WHERE idStage IN (SELECT id FROM stage WHERE login = @userToRemove)

DELETE FROM stageintitule
WHERE idStage IN (SELECT id FROM stage WHERE login = @userToRemove)

DELETE FROM stagetypo
WHERE idStage IN (SELECT id FROM stage WHERE login = @userToRemove)

DELETE FROM stage
WHERE id = @userToRemove


--
-- UTILISATEUR
--

DELETE FROM utilisateur
WHERE login = @userToRemove
