$PBExportHeader$w_about.srw
forward
global type w_about from w_response_base
end type
type p_1 from picture within w_about
end type
type st_3 from statictext within w_about
end type
type shl_1 from statichyperlink within w_about
end type
type st_2 from statictext within w_about
end type
type st_1 from statictext within w_about
end type
end forward

global type w_about from w_response_base
string tag = "about"
integer width = 1285
integer height = 872
string title = "About"
string icon = "png\about.ico"
p_1 p_1
st_3 st_3
shl_1 shl_1
st_2 st_2
st_1 st_1
end type
global w_about w_about

on w_about.create
int iCurrent
call super::create
this.p_1=create p_1
this.st_3=create st_3
this.shl_1=create shl_1
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.shl_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
end on

on w_about.destroy
call super::destroy
destroy(this.p_1)
destroy(this.st_3)
destroy(this.shl_1)
destroy(this.st_2)
destroy(this.st_1)
end on

type p_1 from picture within w_about
integer x = 50
integer y = 96
integer width = 133
integer height = 144
string picturename = "png\about.png"
boolean focusrectangle = false
end type

type st_3 from statictext within w_about
integer x = 50
integer y = 588
integer width = 997
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Copyright © Appeon. All rights reserved."
boolean focusrectangle = false
end type

type shl_1 from statichyperlink within w_about
integer x = 50
integer y = 428
integer width = 1435
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "https://github.com/Appeon/PowerBuilder-Graph-Example"
boolean focusrectangle = false
string url = "https://github.com/Appeon/PowerBuilder-Graph-Example"
end type

type st_2 from statictext within w_about
integer x = 50
integer y = 352
integer width = 430
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "For latest version:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_about
integer x = 219
integer y = 104
integer width = 960
integer height = 164
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Example Graph App"
boolean focusrectangle = false
end type

