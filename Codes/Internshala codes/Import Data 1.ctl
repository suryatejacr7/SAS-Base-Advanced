{"version":2,"type":"import","id":"ba04b3e2-7a0f-4696-8901-a21236c6550b","name":"Import Data 1","label":"Import Data 1","description":"","created":1644391454370,"modified":1644391459993,"notes":"","parameters":{"server":"","target":"com.sas.ep.sascoder.execution.producers.VPP","action":"runSASCode","priority":"Reserved","code":"/* Generated Code (IMPORT) */\r\n/* Source File: M2_T7_V1_-_Bringing_data_into_SAS-mycars.xlsx */\r\n/* Source Path: /home/u60870018 */\r\n/* Code generated on: 2/9/22, 12:54 PM */\r\n\r\n%web_drop_table(WORK.IMPORT);\r\n\r\n\r\nFILENAME REFFILE '/home/u60870018/M2_T7_V1_-_Bringing_data_into_SAS-mycars.xlsx';\r\n\r\nPROC IMPORT DATAFILE=REFFILE\r\n\tDBMS=XLSX\r\n\tOUT=WORK.IMPORT;\r\n\tGETNAMES=YES;\r\nRUN;\r\n\r\nPROC CONTENTS DATA=WORK.IMPORT; RUN;\r\n\r\n\r\n%web_open_table(WORK.IMPORT);","resource":false,"outputType":"TABLE","outputName":"IMPORT","outputLocation":"WORK","fileName":"M2_T7_V1_-_Bringing_data_into_SAS-mycars.xlsx","filePath":"/home/u60870018","fileType":"","fileSheet":"","fileTable":"","delimiterOption":"","dataRowOption":-1,"guessingRowsOption":-1,"getnamesOption":true,"quoteDelimiterOption":true,"eolDelimiterOption":""},"properties":{"left":"20","top":"20","width":"100","height":"60","region":"output","fillcolor":"#E0E6F1","linecolor":"#6882a3","tooltip":"","portsonly":false,"key":"control","visible":true}}