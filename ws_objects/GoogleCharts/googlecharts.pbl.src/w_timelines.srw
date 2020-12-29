$PBExportHeader$w_timelines.srw
forward
global type w_timelines from w_chart_base
end type
type dw_1 from datawindow within w_timelines
end type
type st_1 from statictext within w_timelines
end type
type st_2 from statictext within w_timelines
end type
end forward

global type w_timelines from w_chart_base
string tag = "timelines"
integer width = 4297
integer height = 1992
dw_1 dw_1
st_1 st_1
st_2 st_2
end type
global w_timelines w_timelines

type variables
Boolean ib_flag = True
end variables

forward prototypes
public subroutine wf_apply ()
public function string wf_createdata (datawindow as_dw)
end prototypes

public subroutine wf_apply ();String ls_Title, ls_Data, ls_Option

//Title
ls_Title = "Company Distribution"
wb_1.of_SetTitle(ls_Title)
//Style
wb_1.of_SetStyle("timeline")
////Width
//wb_1.of_SetWidth(800 )
////Height
//wb_1.of_SetHeight(500)
//CreateData
ls_Data = wf_CreateData( dw_1 )
//SetData
wb_1.of_SetData(ls_Data)
//CreateOption
ls_Option = wb_1.of_CreateOption()
//SetOption
wb_1.of_SetOption(ls_Option)
//Apply
wb_1.of_Apply()



end subroutine

public function string wf_createdata (datawindow as_dw);Long		ll_RootArray, ll_ChildObject, ll_ChildObject2, ll_ChildObject3, ll_ChildObject4, ll_ChildArray, ll_i
String		ls_Data, ls_fname, ls_lname, ls_name
JsonGenerator		ljson_Option

ljson_Option = Create JsonGenerator
ll_RootArray = ljson_Option.CreateJsonArray()


TRY
	
	ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
	
	ll_ChildObject = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject, "type", "'string'")
	ljson_Option.AddItemString(ll_ChildObject, "id", "'Row'")
	
	ll_ChildObject2 = ljson_Option.AddItemObject(ll_ChildArray)
	ljson_Option.AddItemString(ll_ChildObject2, "type", "'string'")
	ljson_Option.AddItemString(ll_ChildObject2, "id", "'Row'")
	
	ll_ChildObject3 = ljson_Option.AddItemObject(ll_ChildArray)
	
	ljson_Option.AddItemString(ll_ChildObject3, "type", "'date'")
	ljson_Option.AddItemString(ll_ChildObject3, "id", "'Start'")
	
	ll_ChildObject4 = ljson_Option.AddItemObject(ll_ChildArray)
	
	ljson_Option.AddItemString(ll_ChildObject4, "type", "'date'")
	ljson_Option.AddItemString(ll_ChildObject4, "id", "'End'")
	
	

	FOR ll_i = 1 TO as_dw.RowCount()
		
		ll_ChildArray = ljson_Option.AddItemArray(ll_RootArray)
		ljson_Option.AddItemString(ll_ChildArray, "'"+String(ll_i)+"'")
		ls_fname = wf_GetItemString(as_dw, ll_i, 1) 
		ls_lname = wf_GetItemString(as_dw, ll_i, 2) 
		
		ls_name = ls_fname + " " + ls_lname
		
		ljson_Option.AddItemString(ll_ChildArray, "'"+ls_name+"'")
		
		ljson_Option.AddItemString(ll_ChildArray, "new Date("+"'"+wf_GetItemString(as_dw, ll_i, 3)+"'"+")")
		
		ljson_Option.AddItemString(ll_ChildArray, "new Date("+"'"+wf_GetItemString(as_dw, ll_i, 4)+"'"+")")
	
	NEXT
	
CATCH(throwable ex)
	Messagebox("Error", ex.getmessage())
END TRY

ls_Data = ljson_Option.GetJsonString()


RETURN ls_Data
end function

on w_timelines.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
end on

on w_timelines.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;Long		ll_RowCount, ll_Row, ll_i
String		ls_fname[15], ls_lname[15], ls_start[15], ls_termination[15]


ls_fname[] = {"Kendall", "Fai", "Kylie", "Bella", "Smith", "Emma", "Joe","Mark", "Sheila", "Elizabeth", "Shih","Philip","Julie","Robert","Melissa"}
ls_lname[] = {"Jenner", "Davis", "Jenner", "Hadid", "Sam", "Monella", "Chen","Morrirs", "Romero","Lambert", "Chao","Chin","Jordan","Breault","Espinoza"}
ls_start[] = {"1997-12-18", "1997-07-05", "1995-11-25", "1997-11-07", "1994-11-30", "1996-10-10", "1997-08-09","1997-11-30","1998-01-02","1997-05-28","1996-02-05","1998-09-17","1995-05-31","1996-07-10","1998-12-10"}
ls_termination[] = {"1999-10-01", "2000-03-30", "1999-08-28", "2000-09-21", "1996-10-30", "1999-11-11", "1999-12-30","1999-11-30","1999-11-25","1999-10-15","2000-11-11","2000-12-1","1999-10-21","1999-10-12","2000-11-30"}

dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

ll_RowCount = dw_1.RowCount()

IF ll_RowCount < 24 THEN
	FOR ll_i = 1 TO upperbound(ls_fname)
		ll_Row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_Row, 1, ls_fname[ll_i])
		dw_1.SetItem(ll_Row, 2, ls_lname[ll_i])
		dw_1.SetItem(ll_Row, 3, ls_start[ll_i])
		dw_1.SetItem(ll_Row, 4, ls_termination[ll_i])
		IF ll_RowCount>=24 THEN EXIT
	NEXT
END IF

dw_1.SetSort("#3")
dw_1.Sort()


ib_flag = True

//1.waiting webbrowser init
//2.Navigation DefaultUrl
//3.event wb_1.Navigationprogressindex

end event

type wb_1 from w_chart_base`wb_1 within w_timelines
integer x = 1605
integer y = 112
integer width = 2651
integer height = 1724
end type

event wb_1::navigationprogressindex;call super::navigationprogressindex;IF progressindex = 100 THEN
	IF ib_flag THEN 
		ib_flag = False
		wf_apply()
	END IF
END IF
end event

event wb_1::ue_clicked;call super::ue_clicked;JsonParser lnv_JsonParser
Long 		ll_RootObject, ll_Find, ll_I, ll_index
String 	ls_Name

lnv_JsonParser = Create JsonParser

lnv_JsonParser.LoadString(as_arg)
ll_RootObject = lnv_JsonParser.GetRootItem()
ls_Name = lnv_JsonParser.GetItemString( ll_RootObject, "value" )

ll_index = Pos(ls_Name, " ")

ls_Name = mid(ls_Name, 1, ll_index - 1)

ll_Find = dw_1.Find( "emp_fname = '" + ls_Name + "'" , 1, dw_1.RowCount()  )


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

type dw_1 from datawindow within w_timelines
integer x = 37
integer y = 112
integer width = 1527
integer height = 1724
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_timelines"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_timelines
integer x = 530
integer y = 16
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_timelines
integer x = 2848
integer y = 16
integer width = 389
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
boolean focusrectangle = false
end type

