using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Contacts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //menu Controls
        HtmlControl cntrl = (HtmlControl)Master.FindControl("liContacts");

        if (cntrl != null)
        {
            cntrl.Attributes["class"] = "current_page_item";
        }//end menu controls




        //first time page loads
        if (!Page.IsPostBack)
        {
            
        //look for the qs id (coid)
        //if it is not null
            if (Request.QueryString["coid"] != null)
            {    
                        
             //switch datasource to the qs datasource
                gvContacts.DataSourceID = dsActiveContactsByQS.ID;

                //databind
                gvContacts.DataBind();

                  //only if u have filtering(a ddl on top of page) on ur contacts
                 //SelectedValue of the ddl to the qs value
                //DropDownListsForCompanies.SelectedValue = Request.QueryString["coid"]

                //show the back button ONLY when arriving from the companies page
                //via the querystring
                btnBackToCompanies.Visible = true;

                //hide the checkboxShowInactiveContacts when the qs is executed
                cbShowInactiveContacts.Visible = false;

                
         }


         }





    }
    protected void cbShowInactiveContacts_CheckedChanged(object sender, EventArgs e)
    {

        //switch datasources based on wether or not the checkbox is checked4
        if (cbShowInactiveContacts.Checked)
        {
            gvContacts.DataSourceID = dsInactiveConacts.ID;
        }
        else
        {
            gvContacts.DataSourceID = dsActiveConacts.ID;
        }
        gvContacts.DataBind();
      

    }
    protected void gvContacts_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvContacts.ActiveViewIndex = 1;
    }
    protected void btnAddNewContact_Click(object sender, EventArgs e)
    {
        dvSelectedContact.ChangeMode(DetailsViewMode.Insert);
        mvContacts.ActiveViewIndex = 1;
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        //on insert if user hits cancel send them back to the gv
        mvContacts.ActiveViewIndex = 0;
    }
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        //if customer clicks on update and then hits cancel send back to gv
        mvContacts.ActiveViewIndex = 0;
    }
    protected void btnBackToContacts_Click(object sender, EventArgs e)
    {
        mvContacts.ActiveViewIndex = 0;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        //when you click insert, take user back to the gridview
        mvContacts.ActiveViewIndex = 0;

        //update the GV
        gvContacts.DataBind();
    }

    protected void dsSelectedContact_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //when you click insert, take user back to the gridview
        mvContacts.ActiveViewIndex = 0;

        //update the GV
        gvContacts.DataBind();
    }


    protected void dsSelectedContact_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //when you click insert, take user back to the gridview
        mvContacts.ActiveViewIndex = 0;

        //update the GV
        gvContacts.DataBind();
    }
    protected void btnBackToCompanies_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Companies.aspx");
    }


    //*********SECURITY ADMIN*************

    //secure the LAST COLUMN of the Gridview
    protected void gvContacts_DataBound(object sender, EventArgs e)
    {
        //hide the change status if the user is not an admin
        if (!User.IsInRole("admin"))
        {
            //index is 0 base
            gvContacts.Columns[gvContacts.Columns.Count - 1].Visible = false;
        }
    }

    //secure the LAST ROW of the DetailsView
    protected void dvSelectedContact_DataBound(object sender, EventArgs e)
    {
        if (!User.IsInRole("admin"))
        {
            dvSelectedContact.Rows[dvSelectedContact.Rows.Count - 1].Visible = false;
        }
    }

    protected void AdminControl_PreRender(object sender, EventArgs e)
    {
        //connect this to the PRE RENDER event of each control that u want to hide individually
        //(not used with the gv or dv)
        if (!User.IsInRole("admin"))
        {//cast this object to an control

            ((Control)sender).Visible = false;
        }

        //FOR MULTI USER, YOU CAN ADD THE USER TO A ROLE (CREATE THE ROLE IN THE WSAT i.e. RegisteredUser) AND
        //CHECK THAT THE ROLE AS WELL AS THE ADMIN

        //additionally you will need to add the user to this role in ur create user wizard event handler
        //(see ASP2 - createUserWizard)

        //
        //if (!User.IsInRole("admin") || !User.IsInRole("registeredUser"))
        //{
        //    ((Control)sender).Visible = false;
        //}
    }



   
}