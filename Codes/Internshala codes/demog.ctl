{"version":2,"type":"import","id":"7939b274-1120-4e2c-8cdd-e409e7f46334","name":"Import Data 1","label":"Import Data 1","description":"","created":1650614374475,"modified":1650614401080,"notes":"","parameters":{"server":"","target":"com.sas.ep.sascoder.execution.producers.VPP","action":"runSASCode","priority":"Reserved","code":"/* Generated Code (IMPORT) */\r\n/* Source File: demog.xls */\r\n/* Source Path: /home/u60870018/Internshala */\r\n/* Code generated on: 4/22/22, 1:30 PM */\r\n\r\n%web_drop_table(WORK.demog);\r\n\r\n\r\nFILENAME REFFILE '/home/u60870018/Internshala/demog.xls';\r\n\r\nPROC IMPORT DATAFILE=REFFILE\r\n\tDBMS=XLS\r\n\tOUT=WORK.demog;\r\n\tGETNAMES=YES;\r\nRUN;\r\n\r\nPROC CONTENTS DATA=WORK.demog; RUN;\r\n\r\n\r\n%web_open_table(WORK.demog);","resource":false,"outputType":"TABLE","outputName":"demog","outputLocation":"WORK","fileName":"demog.xls","filePath":"/home/u60870018/Internshala","fileType":"","fileSheet":"","fileTable":"","delimiterOption":"","dataRowOption":-1,"guessingRowsOption":-1,"getnamesOption":true,"quoteDelimiterOption":true,"eolDelimiterOption":""},"properties":{"left":"20","top":"20","width":"100","height":"60","region":"output","fillcolor":"#E0E6F1","linecolor":"#6882a3","tooltip":"","portsonly":false,"key":"control","visible":true}}