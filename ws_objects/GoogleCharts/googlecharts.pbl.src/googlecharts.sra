﻿$PBExportHeader$googlecharts.sra
$PBExportComments$Generated Application Object
forward
global type googlecharts from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_GraphType = "line"
Boolean gb_is3D
end variables
global type googlecharts from application
string appname = "googlecharts"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = ""
string fullbuildruntimeversion = "19.2.0.2635"
string appruntimeversion = "19.2.0.2636"
end type
global googlecharts googlecharts

on googlecharts.create
appname="googlecharts"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on googlecharts.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;////
// Profile PB Demo DB V2019R3
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PB Demo DB V2019R3;UID=dba;PWD=sql'"
Connect;

If SQLCA.sqlcode <> 0 Then
	MessageBox ("Sorry! Cannot Connect To Database", SQLCA.sqlerrtext)
	Halt Close
	Return
End If

String ls_theme

ls_Theme = "Flat Design Blue"
applytheme(GetCurrentDirectory( ) + "\Theme\" + ls_theme)


Open(w_mdi)

end event

