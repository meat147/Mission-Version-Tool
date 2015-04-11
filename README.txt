Installation:

	Datei _netrc
		
		Beschreibung
		Mit Hilfe dieser Datei kann sich git ohne Passworteingabe ein Repository clonen
	
		machine <host>
			Die machine muss mit dem STASH_REPO host übereinstimmen
			
		login <username>
		password <password>
			
			
		Anschließend die Datei in den %userprofile% Ordner kopieren
		
	Anschließend eventuell noch die Pfade in cloneAndBuild.bat anpassen.
		set GITSH="C:\Program Files (x86)\Git\bin\sh.exe"
		set CFG_CONVERT=".\CfgConvert.exe"
		set CPBO=".\cpbo.exe"

		set STASH_REPO="http://stash.taskforce47.de/scm/aiii/tf47-patrolops-altis.git"
		set MISSIONFOLDER="tf47-patrolops.Altis"
		set FINAL_PBO="%MISSIONFOLDER%.pbo"
	