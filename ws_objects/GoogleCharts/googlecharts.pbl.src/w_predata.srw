$PBExportHeader$w_predata.srw
forward
global type w_predata from w_response_base
end type
type st_rowcount from statictext within w_predata
end type
type cb_1 from commandbutton within w_predata
end type
type dw_1 from datawindow within w_predata
end type
end forward

global type w_predata from w_response_base
integer width = 2016
integer height = 1720
string title = "Preview Data"
boolean minbox = true
windowtype windowtype = popup!
string icon = "png\chartapp.ico"
st_rowcount st_rowcount
cb_1 cb_1
dw_1 dw_1
end type
global w_predata w_predata

on w_predata.create
int iCurrent
call super::create
this.st_rowcount=create st_rowcount
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_rowcount
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_predata.destroy
call super::destroy
destroy(this.st_rowcount)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;String 	ls_SQL, ls_DWSyntax, ls_Error


ls_SQL = Message.StringParm
If Len ( ls_SQL) > 0 Then
	ls_DWSyntax = SQLCA.SyntaxFromSQL( ls_SQL, "style(type=grid)", ls_Error )
	If Len ( ls_Error ) > 0 Then
		MessageBox ( "Caution", "SyntaxFromSQL caused these errors: " + ls_Error )
		Return
	End If
	dw_1.Create( ls_DWSyntax, ls_Error)
	If Len ( ls_Error ) > 0 Then
		MessageBox ( "Caution", "Create cause these errors:: " + ls_Error )
		Return
	End If
	
	dw_1.SetTransObject ( SQLCA )
	dw_1.Retrieve()
ELSE
	Messagebox("Tips","Sorry, you haven't generated SQL Syntax")
End If


st_rowcount.Text = "RowCount = " + String(dw_1.RowCount())
end event

type st_rowcount from statictext within w_predata
integer x = 41
integer y = 1360
integer width = 398
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "RowCount = 0"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_predata
integer x = 1582
integer y = 1436
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)
end event

type dw_1 from datawindow within w_predata
integer x = 41
integer y = 44
integer width = 1938
integer height = 1296
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

