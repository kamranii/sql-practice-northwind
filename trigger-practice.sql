BACKUP DATABASE [BankDb]
To DISK='/Users/kamranimranli/Projects/Backup'
WITH FORMAT,
    MEDIANAME = 'SampleBackUp',
    NAME = 'Full-SampleBackUpBankDb'

INSERT Books(Name) VALUES('War and peace') 

BACKUP DATABASE [BankDb]
To DISK='/Users/kamranimranli/Projects/Backup'
WITH DIFFERENTIAL,
    MEDIANAME = 'SampleBackUp',
    NAME = 'Full-SampleBackUpBankDb'

SELECT EVENTDATA()
GO
SELECT Country FROM Addresses GROUP BY Country HAVING COUNT(*) > 1
select IS_MEMBER('db_owner')
select IS_MEMBER('db_owner')

