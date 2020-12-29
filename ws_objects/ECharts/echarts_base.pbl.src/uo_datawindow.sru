$PBExportHeader$uo_datawindow.sru
forward
global type uo_datawindow from datawindow
end type
end forward

global type uo_datawindow from datawindow
integer width = 1253
integer height = 672
boolean titlebar = true
string title = "none"
string dataobject = "d_column_list"
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type
global uo_datawindow uo_datawindow

type variables
String		is_Table


end variables

on uo_datawindow.create
end on

on uo_datawindow.destroy
end on

event clicked;
IF row = 0 THEN RETURN

String		ls_Option, ls_column, ls_json
Long		ll_flag
Long		ll_RootObject, ll_ChildObject, ll_ChildArray
JsonGenerator ljson_Option

ljson_Option = Create JsonGenerator
ll_RootObject = ljson_Option.CreateJsonObject()
ljson_Option.AddItemString(ll_RootObject, "tablename", is_Table)

ls_column = this.GetItemString(row, 1)
IF this.IsSelected(row) THEN
	this.SelectRow(row, False)
	ll_flag = 0
ELSE
	this.SelectRow(row, True)
	ll_flag = 1
END IF

ljson_Option.AddItemString(ll_RootObject, "column", ls_column)
ljson_Option.AddItemNumber(ll_RootObject, "flag", ll_flag)
ls_json = ljson_Option.GetJsonString()

IF IsValid( ljson_Option ) THEN Destroy (ljson_Option)

w_select_list.dynamic post event ue_select_col(ls_json)  
end event

