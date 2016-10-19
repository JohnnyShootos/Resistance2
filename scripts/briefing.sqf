// Command and signals tab and Unit roster are generated automatically based of TFD_ORBAT

player createDiaryRecord ["Diary",
							["Admin and Logistics",
								""]];

player createDiaryRecord ["Diary",
							["Execution",
								"Assets:<br/><br/>- 1 x Company Command Squad<br/><br/>- 3 x 20man platoons of motorised infantry each deployed with 3 x MRAPS<br/><br/>- 1 x Logistics platoon: 4 Medics, 2 Engineers, 2 Drivers<br/><br/>- 1 x Deployable Field Hospital<br/><br/>- 1 x Deployable FARP<br/><br/>- 1 x M2A3 Bradleys IFV (BUSK III)"]];

player createDiaryRecord ["Diary", 
							["Mission", 
								"Assault and the Insurgent controlled city of Paraiso. The insurgent munitions caches must be located and destroyed. You only have 2 hours to complete this task before you will be forced to fall back and other avenues explored."]];
								
player createDiaryRecord ["Diary", 
							["Situation", 
								"CHDKZ Insurgents have seized control of Paraiso and are position themselves for a military coup of the entre Sahrani province. The insurgents have amassed cache's of munitions to aid them in their efforts."]];

rosterPage = player createDiarySubject [ "Admin" , "Admin Instruction" ];

player createDiaryRecord ["Admin", 
							["Starting", 
								'Use START MISSION in scroll menu to un-safety weapons']];