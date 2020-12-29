$PBExportHeader$w_select_table.srw
forward
global type w_select_table from w_response_base
end type
type cb_cancle from commandbutton within w_select_table
end type
type cb_open from commandbutton within w_select_table
end type
type dw_tables from datawindow within w_select_table
end type
end forward

global type w_select_table from w_response_base
string tag = "sqltable"
integer width = 1170
integer height = 1036
string title = "Select Tables"
cb_cancle cb_cancle
cb_open cb_open
dw_tables dw_tables
end type
global w_select_table w_select_table

type variables
String is_Table
end variables

forward prototypes
public function string wf_replace (string as_string, string as_str1, string as_str2)
end prototypes

public function string wf_replace (string as_string, string as_str1, string as_str2);//wf_replace(as_string,as_str1,as_str2)
Long 	start_pos

start_pos = Pos(as_string, as_str1)
DO WHILE start_pos > 0		
	 as_string = Replace(as_string, start_pos, Len(as_str1), as_str2)
	start_pos = Pos(as_string, as_str1, start_pos + Len(as_str2))						
LOOP

RETURN as_string
end function

on w_select_table.create
int iCurrent
call super::create
this.cb_cancle=create cb_cancle
this.cb_open=create cb_open
this.dw_tables=create dw_tables
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancle
this.Control[iCurrent+2]=this.cb_open
this.Control[iCurrent+3]=this.dw_tables
end on

on w_select_table.destroy
call super::destroy
destroy(this.cb_cancle)
destroy(this.cb_open)
destroy(this.dw_tables)
end on

event open;call super::open;String ls_Json, ls_Table, ls_Error
Long 	ll_i, ll_Ret, ll_Find, ll_ScrollToRow, ll_RootObject, ll_Count, ll_ChildItem

JsonParser lnv_JsonParser

ls_Json = Message.StringParm

dw_tables.SetTransObject(sqlca)
IF f_set_table_select(dw_tables) <0 THEN
	Messagebox("Error", &
					"Unable to set SQL select statement for tables list", &
					StopSign!)
	this.Triggerevent( Close! )
END IF

ll_ret  = dw_tables.Retrieve( )
IF ll_ret < 1 THEN
	Messagebox("Retrieve renturn code is:", ll_ret)
END IF

IF Len(ls_Json) >0 THEN
	lnv_JsonParser = Create JsonParser
	ls_Error = lnv_JsonParser.LoadString(ls_Json)
	If Len( ls_Error ) > 0 Then
		MessageBox( "Error", ls_Error )
		Return
	End If
	ll_RootObject = lnv_JsonParser.GetRootItem()
	ll_Count = lnv_JsonParser.GetChildCount( ll_RootObject )	
	FOR ll_i = 1 TO ll_Count
		ll_ChildItem = lnv_JsonParser.GetChildItem(ll_RootObject, ll_I)
		ls_table = lnv_JsonParser.GetItemString(ll_ChildItem)
		ll_Find = dw_Tables.Find("tname='" + ls_table+ "'", 1, dw_Tables.RowCount())
		IF ll_Find > 0 Then
			ll_ScrollToRow = ll_Find
			dw_tables.event clicked(0, 0, ll_Find, dw_tables.object.tname)
		End IF
		If ll_I = 1 Then
			is_Table = ls_table
		Else
			is_Table += "," + ls_table
		End If
	NEXT
	If ll_Count > 0 Then
		cb_Open.Enabled = True
	End If
END IF
dw_Tables.post ScrollToRow( ll_ScrollToRow )

end event

type cb_cancle from commandbutton within w_select_table
integer x = 942
integer y = 204
integer width = 201
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_open from commandbutton within w_select_table
integer x = 942
integer y = 60
integer width = 201
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Open"
end type

event clicked;//
JsonGenerator 	ljson_Generator
Long 	ll_I, ll_RootArray
String ls_Json

ljson_Generator = Create JsonGenerator

ll_RootArray = ljson_Generator.CreateJsonArray()

For ll_I = 1 To dw_tables.RowCount()
	If dw_tables.IsSelected(ll_I) Then
		ljson_Generator.AddItemString(ll_RootArray, dw_tables.GetItemString( ll_I, "tname" ))
	End If
Next

ls_Json = ljson_Generator.GetJsonString()
//dw_tables.IsSelected(row)

IF ls_Json <> "[]" THEN
	CloseWithReturn(parent, ls_Json)
ELSE
	Messagebox("Tips", "You hava not selected tables !")
END IF

end event

type dw_tables from datawindow within w_select_table
integer x = 37
integer y = 32
integer width = 878
integer height = 860
integer taborder = 10
string title = "none"
string dataobject = "d_table_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
String		ls_table

If row = 0 Then Return	

ls_table = dw_tables.GetItemString(row, 1)
IF dw_tables.IsSelected(row) THEN
	dw_tables.SelectRow(row, False)
	
	IF (pos(is_Table, "," + ls_table) > 0) THEN
		is_Table = wf_replace(is_Table, "," + ls_table, "")
	END IF
	IF (pos(is_Table, ls_table+",") > 0) THEN
		is_Table = wf_replace(is_Table, ls_table+",", "")
	END IF
	IF is_Table = ls_table THEN
		is_Table = ""
	END IF
ELSE
	dw_tables.SelectRow(row, True)
	
	IF Len(is_Table) > 0 THEN
		is_Table += "," + ls_table
	ELSE
		is_Table = ls_table
	END IF
END IF

If Len ( is_Table ) > 0 Then
	cb_open.Enabled = True
Else
	cb_open.Enabled = False
End If




end event

