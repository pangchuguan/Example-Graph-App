$PBExportHeader$w_select_list.srw
forward
global type w_select_list from w_response_base
end type
type cb_1 from commandbutton within w_select_list
end type
type cbx_series from checkbox within w_select_list
end type
type ddlb_2 from dropdownlistbox within w_select_list
end type
type ddlb_1 from dropdownlistbox within w_select_list
end type
type ddlb_3 from dropdownlistbox within w_select_list
end type
type st_4 from statictext within w_select_list
end type
type st_3 from statictext within w_select_list
end type
type cb_close from commandbutton within w_select_list
end type
type cb_ok from commandbutton within w_select_list
end type
type st_1 from statictext within w_select_list
end type
type st_2 from statictext within w_select_list
end type
type mle_1 from multilineedit within w_select_list
end type
type tab_1 from tab within w_select_list
end type
type tabpage_columns from userobject within tab_1
end type
type dw_columns from datawindow within tabpage_columns
end type
type tabpage_columns from userobject within tab_1
dw_columns dw_columns
end type
type tabpage_join from userobject within tab_1
end type
type dw_join from datawindow within tabpage_join
end type
type tabpage_join from userobject within tab_1
dw_join dw_join
end type
type tabpage_where from userobject within tab_1
end type
type dw_where from datawindow within tabpage_where
end type
type tabpage_where from userobject within tab_1
dw_where dw_where
end type
type tabpage_group from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_group
end type
type dw_1 from datawindow within tabpage_group
end type
type tabpage_group from userobject within tab_1
dw_2 dw_2
dw_1 dw_1
end type
type tab_1 from tab within w_select_list
tabpage_columns tabpage_columns
tabpage_join tabpage_join
tabpage_where tabpage_where
tabpage_group tabpage_group
end type
type uo_1 from uo_window within w_select_list
end type
end forward

global type w_select_list from w_response_base
integer width = 3497
integer height = 2708
string title = "Table Layout"
event ue_select_col ( string as_json )
event ue_select_table ( )
cb_1 cb_1
cbx_series cbx_series
ddlb_2 ddlb_2
ddlb_1 ddlb_1
ddlb_3 ddlb_3
st_4 st_4
st_3 st_3
cb_close cb_close
cb_ok cb_ok
st_1 st_1
st_2 st_2
mle_1 mle_1
tab_1 tab_1
uo_1 uo_1
end type
global w_select_list w_select_list

type variables
String		is_Table, is_Json
Long		il_row,il_row2
Boolean	ib_prim_ldown,ib_prim_rdown
Boolean 	ib_AutoCommit

uo_datawindow	iuo_table[]
end variables

forward prototypes
protected subroutine wf_sqlsyntax ()
end prototypes

event ue_select_col(string as_json);String		ls_json, ls_column, ls_table_column, ls_table, ls_string
Long		ll_RootObject, ll_flag, ll_i, ll_Find
Long		ll_type, ll_index, ll_Row
Boolean	lb_number
JsonParser lnv_JsonParser

lnv_JsonParser = create JsonParser

ls_Json = as_json
lnv_JsonParser.LoadString(ls_Json)
ll_RootObject = lnv_JsonParser.GetRootItem()

ls_table = lnv_JsonParser.GetItemString(ll_RootObject, "tablename")
ls_column = lnv_JsonParser.GetItemString(ll_RootObject, "column")
ll_flag = lnv_JsonParser.GetItemNumber(ll_RootObject, "flag")
ls_table_column = ls_table + "_" + ls_column

IF ll_flag = 1 THEN
	ll_Row = tab_1.tabpage_columns.dw_columns.InsertRow(0)
	tab_1.tabpage_columns.dw_columns.SetItem(ll_Row , "columname", ls_table+"."+ls_column)
	tab_1.tabpage_columns.dw_columns.SetItem(ll_Row , "columnameas", ls_table_column)
ELSEIF ll_flag = 0 THEN
	ll_Find = tab_1.tabpage_columns.dw_columns.Find( "columname = '" + ls_table+"."+ls_column + "'", 1, tab_1.tabpage_columns.dw_columns.RowCount() )
	tab_1.tabpage_columns.dw_columns.DeleteRow(ll_Find)
END IF

/*Get field*/
SELECT "dbo"."syscolumns"."type"  
 INTO :ll_type
 FROM "dbo"."syscolumns",   
			"dbo"."sysobjects",   
			"dbo"."systypes"  
WHERE ( "dbo"."syscolumns"."id" = "dbo"."sysobjects"."id" ) and
		( ( "dbo"."sysobjects"."type" = 'U' ) AND  
		("dbo"."sysobjects"."name" = :ls_table) AND
		("dbo"."syscolumns"."name" = :ls_column ));

CHOOSE CASE ll_type
	CASE 45, 37, 48, 52, 56, 62, 63, 38, &
			109, 59, 55, 106, 108, 122, 58
		lb_number = true
END CHOOSE

/*Category (x axis) drop-down options*/
IF ll_flag = 1 THEN
	ddlb_1.Additem(ls_table_column)
ELSEIF ll_flag = 0 THEN
	ll_index = ddlb_1.FindItem(ls_table_column, 0)
	IF ll_index > 0 THEN
		ddlb_1.Deleteitem( ll_index)
		IF ddlb_1.text = ls_table_column Then
			ddlb_1.text =""
		End If
	END IF
END IF


/*Values (y-axis) drop-down options*/
IF ll_flag = 1 THEN
	IF lb_number THEN
		ddlb_2.AddItem(ls_table_column)
		ls_string = "Sum(" + ls_table_column + ")"
		ddlb_2.AddItem(ls_string)
	ELSE
		ls_string = "Count("+ ls_table_column +")"
		ddlb_2.Additem( ls_string )
	END IF
ELSE        //Select when there is no click (highlighted)
	IF lb_number THEN
		ll_index = ddlb_2.Finditem(ls_table_column, 0)
		IF ll_index > 0 THEN
			ddlb_2.Deleteitem( ll_index)
			IF ddlb_2.text = ls_table_column Then
				ddlb_2.text =""
			End If
		END IF
		ll_index = ddlb_2.Finditem("Sum(" + ls_table_column + ")", 0)
		IF ll_index > 0 THEN
			ddlb_2.Deleteitem( ll_index)
			IF ddlb_2.text = "Sum(" + ls_table_column + ")" Then
				ddlb_2.text =""
			End If
		END IF
	ELSE
		ll_index = ddlb_2.Finditem("Count(" + ls_table_column + ")", 0)
		IF ll_index > 0 THEN
			ddlb_2.Deleteitem( ll_index)
			IF ddlb_2.text = "Count(" + ls_table_column + ")" Then
				ddlb_2.text =""
			End If
		END IF
	END IF
END IF

/*Series drop-down options*/
IF ll_flag =1 THEN
	ddlb_3.Additem(ls_table_column)
ELSE
	ll_index = ddlb_3.FindItem(ls_table_column, 0)
	IF ll_index > 0 THEN
		ddlb_3.Deleteitem( ll_index)
		IF ddlb_3.text = ls_table_column Then
			ddlb_3.text =""
		End If
	END IF
END IF

//SqlSyntax
wf_sqlsyntax()


end event

event ue_select_table();String 	ls_json, ls_error, ls_tableName, ls_ColumnName, ls_columns, ls_table
Long 		ll_RootItem, ll_Count, ll_ChildItem, ll_Row
Long		ll_i, ll_xlocate, ll_ylocate, ll_j
JsonParser 	ljson_Parser


OpenWithParm(w_select_table, is_Json)

ls_json = Message.StringParm

If Len( ls_Json ) <= 0 Then Return

ljson_Parser = Create JsonParser
ls_error = ljson_Parser.LoadString(ls_json)
If Len ( ls_error ) > 0 Then
	MessageBox ( "Error", ls_Error )
	Return
End If

is_Json = ls_json

//reset
For ll_I = 1 To UpperBound( iuo_table )
	If IsValid ( iuo_table[ll_I] ) Then
		uo_1.CloseUserObject(iuo_table[ll_I])
	End If
Next
tab_1.tabpage_columns.dw_columns.Reset()
tab_1.tabpage_join.dw_join.Reset()
tab_1.tabpage_where.dw_where.Reset()
tab_1.tabpage_group.dw_1.Reset()
tab_1.tabpage_group.dw_2.Reset()
ddlb_1.reset()
ddlb_2.reset()
ddlb_3.reset()

ll_RootItem = ljson_Parser.GetRootitem( )
ll_Count = ljson_Parser.GetChildCount( ll_RootItem )
For ll_I = 1 To ll_Count
	ll_ChildItem = ljson_Parser.GetChildItem(ll_RootItem, ll_I)
	ls_tableName = ljson_Parser.GetItemString(ll_ChildItem)
	
	If ll_I = 1 Then
		ls_table = ls_tableName
	Else
		ls_table += "," + ls_tableName
	End If
	
	ll_ylocate = uo_1.y + 5
	uo_1.OpenUserobject( iuo_table[ll_i], 50 + (ll_i - 1) * 1300, ll_ylocate )
	iuo_table[ll_i].Title = ls_tableName
	
	IF f_set_column_select(iuo_table[ll_i], ls_tableName) > 0 THEN
		iuo_table[ll_i].SetTransObject(sqlca)
		iuo_table[ll_i].Retrieve()
		iuo_table[ll_i].is_Table = ls_tableName
	END IF
	
	FOR ll_j = 1 TO iuo_table[ll_i].RowCount()
		ls_ColumnName = iuo_table[ll_i].GetItemString(ll_j, "cname")
		ls_columns +="/" + ls_tableName+"."+ ls_ColumnName
		ll_Row = tab_1.tabpage_group.dw_1.InsertRow(0)
		tab_1.tabpage_group.dw_1.SetItem(ll_Row, 1, ls_tableName + "_" + ls_ColumnName  )
	NEXT
	
Next
tab_1.tabpage_join.dw_join.modify("expression1.values = " + "'"+ ls_columns +"'")
tab_1.tabpage_join.dw_join.modify("expression2.values = " + "'"+ ls_columns +"'")
tab_1.tabpage_where.dw_where.modify("expression1.values = " + "'"+ls_columns+"'")

//mle_1.text
IF ls_table <> "" THEN
	is_Table = ls_table
	mle_1.text = "SELECT <not specified> FROM" + " " + is_table
END IF

tab_1.tabpage_join.dw_join.InsertRow(0)
tab_1.tabpage_where.dw_where.InsertRow(0)


end event

protected subroutine wf_sqlsyntax ();Long		ll_RowCount_col, ll_RowCount_group, ll_i, ll_j, ll_index, ll_flag
String		ls_col, ls_group, ls_SQL
String		ls_join, ls_join1, ls_join2, ls_join3, ls_join4
String		ls_where, ls_where1, ls_where2, ls_where3, ls_where4
String 	ls_name,ls_colasname

 tab_1.tabpage_columns.dw_columns.AcceptText()
 tab_1.tabpage_join.dw_join.AcceptText()
 tab_1.tabpage_where.dw_where.AcceptText()
 
 
//Select
ll_RowCount_col = tab_1.tabpage_columns.dw_columns.RowCount()

IF ll_RowCount_col > 0 THEN
	FOR ll_i = 1 TO ll_RowCount_col	
		ls_name = tab_1.tabpage_columns.dw_columns.GetItemString(ll_i, "columname")
		ls_colasname= tab_1.tabpage_columns.dw_columns.GetItemString(ll_i, "columnameas")
		IF Len(ls_col) > 0 THEN
			ls_col += "," +  ls_name + " AS " + '"' + ls_colasname + '"'
		ELSE
			ls_col =  ls_name + " AS " + '"' + ls_colasname + '"'
		END IF
		ls_SQL = "SELECT " + ls_col + " FROM " + is_Table
	NEXT
	
ELSE
	ls_SQL  = "SELECT <not specified>" + " FROM " + is_Table 
END IF



//join
FOR ll_i = 1 TO tab_1.tabpage_join.dw_join.RowCount()
	ls_join1 = tab_1.tabpage_join.dw_join.GetItemString(ll_i, 1)
	IF isNull(ls_join1) THEN ls_join1 = ""
	ls_join2 = tab_1.tabpage_join.dw_join.GetItemString(ll_i, 2)
	IF isNull(ls_join2) THEN ls_join2 = ""
	ls_join3 = tab_1.tabpage_join.dw_join.GetItemString(ll_i, 3)
	IF isNull(ls_join3) THEN ls_join3 = ""
	ls_join4 = tab_1.tabpage_join.dw_join.GetItemString(ll_i, 4)
	IF isNull(ls_join4) THEN ls_join4 = ""
	IF ls_join1 <> "" AND ls_join2 <> "" AND ls_join3 <> "" THEN 
		ls_join += " ( " + ls_join1 + " " + ls_join2 + " " + ls_join3 + " ) " 
	END IF
	If ll_i < tab_1.tabpage_join.dw_join.RowCount() and Len(ls_join4) > 0 Then
		ls_join +=  Upper ( ls_join4 ) + " "
	End If
	
NEXT

IF Len(ls_join) > 0 THEN
	ls_SQL += " WHERE " + ls_join
END IF

	
//where
FOR  ll_i = 1 TO tab_1.tabpage_where.dw_where.RowCount()
	ls_where1 = tab_1.tabpage_where.dw_where.GetItemString(ll_i, 1)
	IF isNull(ls_where1) THEN ls_where1 = ""
	ls_where2 = tab_1.tabpage_where.dw_where.GetItemString(ll_i, 2)
	IF isNull(ls_where2) THEN ls_where2 = ""
	ls_where3 = tab_1.tabpage_where.dw_where.GetItemString(ll_i, 3)
	IF isNull(ls_where3) THEN ls_where3 = ""
	ls_where4 = tab_1.tabpage_where.dw_where.GetItemString(ll_i, 4)
	IF isNull(ls_where4) THEN ls_where4 = ""
	
	IF ls_where1 <> "" AND ls_where2 <> "" AND ls_where3 <> "" THEN 
		ls_where += " ( " + ls_where1 + " " + ls_where2 + " " + ls_where3 + ") " + Upper( ls_where4 ) + " "
	END IF
	If ll_i < tab_1.tabpage_where.dw_where.RowCount() and Len(ls_where4) > 0 Then
		ls_where += Upper( ls_where4 ) + " "
	End If
	
NEXT

IF Len(ls_where) > 0 THEN
	IF Len(ls_join) > 0 THEN
		ls_SQL +=  " AND "+ "(" + ls_where + " )"
	ELSE
		ls_SQL += " WHERE " + ls_where
	END IF
END IF
	

//group by
ll_RowCount_group = tab_1.tabpage_group.dw_2.RowCount()

FOR ll_j = 1 TO ll_RowCount_group
	IF Len(ls_group) > 0 THEN
		ls_group +=  "," + tab_1.tabpage_group.dw_2.GetItemString(ll_j, 1)
	ELSE
		ls_group = tab_1.tabpage_group.dw_2.GetItemString(ll_j, 1)
	END IF
NEXT

IF ls_group <> "" THEN
		ls_SQL += " GROUP BY " + ls_group
END IF

mle_1.text = ls_SQL
end subroutine

on w_select_list.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cbx_series=create cbx_series
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.ddlb_3=create ddlb_3
this.st_4=create st_4
this.st_3=create st_3
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_2=create st_2
this.mle_1=create mle_1
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cbx_series
this.Control[iCurrent+3]=this.ddlb_2
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.ddlb_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.mle_1
this.Control[iCurrent+13]=this.tab_1
this.Control[iCurrent+14]=this.uo_1
end on

on w_select_list.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cbx_series)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.ddlb_3)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.tab_1)
destroy(this.uo_1)
end on

event open;call super::open;//
//Open
ib_AutoCommit = SQLCA.AutoCommit
If Not ib_AutoCommit Then
	SQLCA.AutoCommit = TRUE
End If

post Event ue_select_table()
end event

event close;call super::close;//
If Not ib_AutoCommit Then
	SQLCA.AutoCommit = ib_AutoCommit
End If
end event

type cb_1 from commandbutton within w_select_list
integer x = 2066
integer y = 2440
integer width = 402
integer height = 104
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
end type

event clicked;String		ls_SQL

ls_SQL = mle_1.text

If Len ( ls_SQL ) > 0 Then
	OpenWithParm(w_predata, ls_SQL)
End If
end event

type cbx_series from checkbox within w_select_list
integer x = 55
integer y = 2364
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Series:"
end type

event clicked;IF this.Checked THEN
	ddlb_3.Enabled = TRUE
ELSE
	ddlb_3.Enabled = FALSE
END IF
end event

type ddlb_2 from dropdownlistbox within w_select_list
integer x = 315
integer y = 2228
integer width = 809
integer height = 376
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_select_list
integer x = 315
integer y = 2108
integer width = 809
integer height = 376
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_3 from dropdownlistbox within w_select_list
integer x = 315
integer y = 2356
integer width = 809
integer height = 376
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_select_list
integer x = 55
integer y = 2244
integer width = 146
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Value:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_select_list
integer x = 55
integer y = 2116
integer width = 242
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Category:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_select_list
integer x = 3035
integer y = 2440
integer width = 402
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_select_list
integer x = 2555
integer y = 2440
integer width = 402
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;String 	ls_SQL, ls_Category, ls_Values, ls_Series, ls_Json
Long 		ll_RootObject
JsonGenerator lnv_JsonGenerator


ls_SQL=Trim(mle_1.text)
IF IsNull(ls_SQL) Or ls_SQL = "" THEN
	Messagebox("Tips","SQL syntax is empty!")
	Return
END IF

ls_Category = ddlb_1.Text
IF IsNull(ls_Category) Or ls_Category = "" THEN
	Messagebox("Tips","Category is empty!")
	Return
END IF

ls_Values = ddlb_2.Text
IF IsNull(ls_Values) Or ls_Values = "" THEN
	Messagebox("Tips","Values is empty!")
	Return
END IF

If cbx_Series.Checked Then
	ls_Series = ddlb_3.Text
	IF IsNull(ls_Series) Or ls_Series = "" THEN
		Messagebox("Tips","Series is empty!")
		Return
	END IF
End If

lnv_JsonGenerator = Create JsonGenerator

ll_RootObject = lnv_JsonGenerator.CreateJsonObject ()
lnv_JsonGenerator.AddItemString(ll_RootObject, "SQL", ls_SQL)
lnv_JsonGenerator.AddItemString(ll_RootObject, "Category", ls_Category)
lnv_JsonGenerator.AddItemString(ll_RootObject, "Value", ls_Values)
lnv_JsonGenerator.AddItemString(ll_RootObject, "Series", ls_Series)
lnv_JsonGenerator.AddItemString(ll_RootObject, "Table", is_Table)

ls_Json = lnv_JsonGenerator.GetJsonString()
IF IsValid(  lnv_JsonGenerator ) THEN Destroy ( lnv_JsonGenerator)

//Return the SQL statement to w_table
CloseWithReturn(w_select_list, ls_json)

end event

type st_1 from statictext within w_select_list
integer x = 41
integer y = 12
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selection Lists:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_select_list
integer x = 41
integer y = 1576
integer width = 219
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Syntax:"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_select_list
integer x = 41
integer y = 1636
integer width = 3401
integer height = 428
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tab_1 from tab within w_select_list
integer x = 41
integer y = 916
integer width = 3419
integer height = 660
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_columns tabpage_columns
tabpage_join tabpage_join
tabpage_where tabpage_where
tabpage_group tabpage_group
end type

on tab_1.create
this.tabpage_columns=create tabpage_columns
this.tabpage_join=create tabpage_join
this.tabpage_where=create tabpage_where
this.tabpage_group=create tabpage_group
this.Control[]={this.tabpage_columns,&
this.tabpage_join,&
this.tabpage_where,&
this.tabpage_group}
end on

on tab_1.destroy
destroy(this.tabpage_columns)
destroy(this.tabpage_join)
destroy(this.tabpage_where)
destroy(this.tabpage_group)
end on

type tabpage_columns from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3383
integer height = 528
long backcolor = 67108864
string text = "    Columns    "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_columns dw_columns
end type

on tabpage_columns.create
this.dw_columns=create dw_columns
this.Control[]={this.dw_columns}
end on

on tabpage_columns.destroy
destroy(this.dw_columns)
end on

type dw_columns from datawindow within tabpage_columns
integer x = -32
integer y = -4
integer width = 3451
integer height = 592
integer taborder = 20
string title = "none"
string dataobject = "d_sqlcolumns"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_join from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3383
integer height = 528
long backcolor = 67108864
string text = "    Join    "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_join dw_join
end type

on tabpage_join.create
this.dw_join=create dw_join
this.Control[]={this.dw_join}
end on

on tabpage_join.destroy
destroy(this.dw_join)
end on

type dw_join from datawindow within tabpage_join
integer x = -9
integer y = -8
integer width = 3442
integer height = 612
integer taborder = 20
string title = "none"
string dataobject = "d_sqljoin"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;

IF (dwo.name = "logical" AND Len(data) > 0 AND row = RowCount() ) THEN
	InsertRow(0)	
END IF

wf_sqlsyntax()

end event

type tabpage_where from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3383
integer height = 528
long backcolor = 67108864
string text = "    Where    "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_where dw_where
end type

on tabpage_where.create
this.dw_where=create dw_where
this.Control[]={this.dw_where}
end on

on tabpage_where.destroy
destroy(this.dw_where)
end on

type dw_where from datawindow within tabpage_where
integer x = -9
integer y = -8
integer width = 3470
integer height = 616
integer taborder = 20
string title = "none"
string dataobject = "d_sqlwhere"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
IF (dwo.name = "logical" AND Len(data) > 0 AND row = RowCount()) THEN
	InsertRow(0)
END IF

wf_sqlsyntax()
end event

type tabpage_group from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3383
integer height = 528
long backcolor = 67108864
string text = "    Group    "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_group.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on tabpage_group.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from datawindow within tabpage_group
event ue_lmouse_down pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
integer x = 1618
integer y = -24
integer width = 1765
integer height = 608
integer taborder = 10
string dragicon = "png\row.ico"
string title = "none"
string dataobject = "d_column_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lmouse_down;ib_prim_rdown = true
end event

event ue_mousemove;IF ib_prim_rdown and il_row2 > 0 THEN
	this.Drag(begin!)
END IF
end event

event ue_lmouse_up;ib_prim_rdown = False
This.SelectRow(0, false)
end event

event clicked;il_row2 = Row
if row > 0 then
	This.SelectRow(row, true)
end if
end event

event dragdrop;Long 	ll_to, ll_Find
String ls_Name
DataWindow	ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
IF TypeOf(ldo_object) = DataWindow! THEN
	ldw_control = ldo_object
	If ldw_control = This Then Return
	
	ls_Name = ldw_control.GetItemString( il_row, "cname" )
	ll_Find = This.Find( "cname='" + ls_Name + "'", 1, This.RowCount() )
	If ll_Find > 0 Then Return
	
	ll_to = This.RowCount() + 1
	ldw_control.RowsCopy(il_row, il_row, Primary!, this, ll_to, Primary!)
	ldw_control.Drag(End!)
	//SqlSyntax
	wf_sqlsyntax()
END IF
end event

type dw_1 from datawindow within tabpage_group
event ue_lmouse_down pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
integer x = -18
integer y = -16
integer width = 1678
integer height = 604
integer taborder = 20
string dragicon = "png\row.ico"
string title = "none"
string dataobject = "d_column_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lmouse_down;ib_prim_ldown = true
end event

event ue_mousemove;IF ib_prim_ldown and il_row > 0 THEN
	this.Drag(begin!)
END IF
end event

event ue_lmouse_up;ib_prim_ldown = False
This.SelectRow(0, false)
end event

event clicked;il_row = Row
if row > 0 then
	This.SelectRow(row, true)
end if
end event

event dragdrop;DataWindow	ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
IF TypeOf(ldo_object) = DataWindow! THEN
	ldw_control = ldo_object
	If ldw_control = This Then Return
	ldw_control.RowsDiscard(il_row2, il_row2, Primary!)
	ldw_control.Drag(End!)
	//SqlSyntax
	wf_sqlsyntax()
END IF


end event

type uo_1 from uo_window within w_select_list
integer x = 41
integer y = 76
integer width = 3401
integer height = 824
integer taborder = 10
end type

on uo_1.destroy
call uo_window::destroy
end on

event rbuttondown;call super::rbuttondown;Long		ll_i
m_popup m_new

m_new = CREATE m_popup

m_new.m_selecttable.enabled = true
m_popup.popmenu(this.pointerX() + this.x, this.PointerY() + this.y)

end event

type wb_1 from w_chart_base`wb_1 within w_select_list
boolean visible = false
integer x = 3429
integer y = 136
end type

