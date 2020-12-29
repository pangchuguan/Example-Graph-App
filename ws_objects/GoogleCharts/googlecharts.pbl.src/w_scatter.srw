$PBExportHeader$w_scatter.srw
forward
global type w_scatter from w_chart_base
end type
type dw_1 from datawindow within w_scatter
end type
type rb_1 from radiobutton within w_scatter
end type
type rb_2 from radiobutton within w_scatter
end type
type rb_3 from radiobutton within w_scatter
end type
type rb_4 from radiobutton within w_scatter
end type
type st_1 from statictext within w_scatter
end type
type st_2 from statictext within w_scatter
end type
end forward

global type w_scatter from w_chart_base
string tag = "scatter"
integer width = 4658
integer height = 2200
boolean border = false
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
st_1 st_1
st_2 st_2
end type
global w_scatter w_scatter

type variables
Boolean ib_flag = True
end variables

forward prototypes
public subroutine wf_apply ()
end prototypes

public subroutine wf_apply ();String ll_SeriesName, ls_SeriesName2, ls_Category
Double ldb_Value
int ll_SeriesCount, ll_i
Long ll_Row, ll_Row2, ll_DataCount, ll_j
String ls_Title, ls_Option, ls_data


//Title
wb_1.of_SetTitle("Stock Markets")
//Style
wb_1.of_SetStyle("scatter")
//Width
wb_1.of_SetWidth(800)
//Height
wb_1.of_SetHeight(500)
//CreateData
ls_data = wb_1.of_CreateData(dw_1, "month", "compute_1")
wb_1.of_SetData(ls_data)
//CreateOption
ls_Option =  wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()

end subroutine

event open;call super::open;
dw_1.SetTransObject( sqlca)
dw_1.Retrieve()

ib_flag = True

//1.waiting webbrowser init
//2.Navigation DefaultUrl
//3.event wb_1.Navigationprogressindex
end event

on w_scatter.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
end on

on w_scatter.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.st_1)
destroy(this.st_2)
end on

type wb_1 from w_chart_base`wb_1 within w_scatter
integer x = 1605
integer y = 148
integer width = 3008
integer height = 1900
end type

event wb_1::navigationprogressindex;call super::navigationprogressindex;IF progressindex = 100 THEN
	IF ib_flag THEN 
		ib_flag = False
		wf_apply()
	END IF
END IF
end event

event wb_1::ue_clicked;call super::ue_clicked;
JsonParser lnv_JsonParser
Long 		ll_RootObject, ll_Find, ll_I
String 	ls_Name

lnv_JsonParser = Create JsonParser

lnv_JsonParser.LoadString(as_arg)
ll_RootObject = lnv_JsonParser.GetRootItem()
ls_Name = lnv_JsonParser.GetItemString( ll_RootObject, "name" )

ll_Find = dw_1.Find( "month = '" + ls_Name + "'", 1, dw_1.RowCount()  )
If ll_Find > 0 Then
	dw_1.SetRedraw(False)
	dw_1.ScrollToRow(dw_1.RowCount())
	dw_1.ScrollToRow(ll_Find)
	dw_1.selectrow( 0, False )
	dw_1.selectrow( ll_Find, True )
	dw_1.SetRedraw(True)
End If

If IsValid ( lnv_JsonParser ) Then Destroy ( lnv_JsonParser )
end event

type dw_1 from datawindow within w_scatter
integer x = 41
integer y = 140
integer width = 1522
integer height = 1544
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_scatter"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_scatter
integer x = 247
integer y = 1772
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "AVG (Open)"
boolean checked = true
end type

event clicked;String ll_SeriesName, ls_SeriesName2, ls_Category
Double ldb_Value
int ll_SeriesCount, ll_i
Long ll_Row, ll_Row2, ll_DataCount, ll_j
String ls_Title, ls_Option, ls_data


//Title
wb_1.of_SetTitle("Stock Markets")
//Style
wb_1.of_SetStyle("scatter")
//Width
wb_1.of_SetWidth(800)
//Height
wb_1.of_SetHeight(500)
//CreateData
ls_data = wb_1.of_CreateData(dw_1, "month", "compute_1")
wb_1.of_SetData(ls_data)
//CreateOption
ls_Option =  wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()

end event

type rb_2 from radiobutton within w_scatter
integer x = 951
integer y = 1772
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "AVG (Close)"
end type

event clicked;String ll_SeriesName, ls_SeriesName2, ls_Category
Double ldb_Value
int ll_SeriesCount, ll_i
Long ll_Row, ll_Row2, ll_DataCount, ll_j
String ls_Title, ls_Option, ls_data

//Title
wb_1.of_SetTitle("Stock Markets")
//Style
wb_1.of_SetStyle("scatter")
//Width
wb_1.of_SetWidth(800)
//Height
wb_1.of_SetHeight(500)
//CreateData
ls_data = wb_1.of_CreateData(dw_1, "month", "compute_2")
wb_1.of_SetData(ls_data)
//CreateOption
ls_Option =  wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()

end event

type rb_3 from radiobutton within w_scatter
integer x = 247
integer y = 1908
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "AVG (Highest)"
end type

event clicked;String ll_SeriesName, ls_SeriesName2, ls_Category
Double ldb_Value
int ll_SeriesCount, ll_i
Long ll_Row, ll_Row2, ll_DataCount, ll_j
String ls_Title, ls_Option, ls_data


//Title
wb_1.of_SetTitle("Stock Markets")
//Style
wb_1.of_SetStyle("scatter")
//Width
wb_1.of_SetWidth(800)
//Height
wb_1.of_SetHeight(500)
//CreateData
ls_data = wb_1.of_CreateData(dw_1, "month", "compute_3")
wb_1.of_SetData(ls_data)
//CreateOption
ls_Option =  wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()

end event

type rb_4 from radiobutton within w_scatter
integer x = 951
integer y = 1908
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "AVG (Lowest)"
end type

event clicked;String ll_SeriesName, ls_SeriesName2, ls_Category
Double ldb_Value
int ll_SeriesCount, ll_i
Long ll_Row, ll_Row2, ll_DataCount, ll_j
String ls_Title, ls_Option, ls_data

//Title
wb_1.of_SetTitle("Stock Markets")
//Style
wb_1.of_SetStyle("scatter")
//Width
wb_1.of_SetWidth(800)
//Height
wb_1.of_SetHeight(500)
//CreateData
ls_data = wb_1.of_CreateData(dw_1, "month", "compute_4")
wb_1.of_SetData(ls_data)
//CreateOption
ls_Option =  wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()

end event

type st_1 from statictext within w_scatter
integer x = 530
integer y = 36
integer width = 562
integer height = 80
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Grid DataWindow"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_scatter
integer x = 2949
integer y = 36
integer width = 475
integer height = 80
boolean bringtotop = true
integer textsize = -11
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "WebBrowser"
alignment alignment = center!
boolean focusrectangle = false
end type

