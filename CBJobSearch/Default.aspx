<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="CBJobSearch._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="/Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="/Scripts/Keanna.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <fieldset>
        <legend>Simple Search</legend>
        <div class="mainText" contenteditable="inherit" dir="ltr">
            I want to search within the
            <asp:DropDownList ID="DropDown1" runat="server" PlaceHolder="What Job Category?">
            </asp:DropDownList>
            job category, preferably located near the
            <asp:TextBox ID="TextBox1" runat="server" MaxLength="50" ClientIDMode="Static" PlaceHolder='e.g. "Atlanta, GA" or "30092"'
                CssClass="form-inputOn">
            </asp:TextBox>
            area.
            <br />
            <div class="divider">
                ------------ or ------------</div>
            I want to search by
            <asp:TextBox ID="TextBox2" runat="server" MaxLength="50" ClientIDMode="Static" PlaceHolder='Keywords e.g. "Web Developer" (Comma Separate)'
                CssClass="form-inputOn">
            </asp:TextBox>
            .
            <br />
            <br />
            <asp:Button ID="SearchButton" runat="server" Text="Search!" />
        </div>
    </fieldset>

    <asp:PlaceHolder ID="ph_searchRes" runat="server" Visible="false">
        <div class="listWrap">
            <div class="foam_outer">
                <div class="foam_inner">
                    <div class="jl_hdr_div">
                        Search Results
                    </div>
                </div>
            </div>  
            <asp:Repeater ID="rptList" runat="server">
        
                <HeaderTemplate>
                <table class="results">
                <tr class="tblHeader">
                    <th class="jt" >Job Title / Description</th>
                    <th class="special-col">Company</th>
                    <th class="special-col">Location</th>
                </tr>          
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <td>
                            <a class="jtLinks" href=<%#DataBinder.Eval(Container.DataItem, "JobDetailsURL")%> > <%#DataBinder.Eval(Container.DataItem, "JobTitle")%></a>
                            -
                            <strong>
                                <a class="simJob" href=<%#DataBinder.Eval(Container.DataItem, "SimilarJobsURL")%>>View similar jobs</a>
                            </strong>
                            <div class="tease">
                                Job type: <%#DataBinder.Eval(Container.DataItem, "EmploymentType") %> | Pay: <%#DataBinder.Eval(Container.DataItem, "Pay") %>
                                <br />
                                <%#DataBinder.Eval(Container.DataItem, "DescriptionTeaser") %>
                                <br />
                            </div>
                        </td>
                        <td><a class="cLinks" href=<%#DataBinder.Eval(Container.DataItem, "CompanyDetailsURL")%>><%#DataBinder.Eval(Container.DataItem, "Company") %></a>
                        </td>
                        <td><asp:Label ID = "Location" class="tblLocation" Text ='<%# DataBinder.Eval(Container.DataItem, "Location") %>' runat="server" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                </table>
                </FooterTemplate>
        
            </asp:Repeater>
        </div>
    </asp:PlaceHolder>
</asp:Content>
