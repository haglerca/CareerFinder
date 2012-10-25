using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Communications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {   //menu Controls
        HtmlControl cntrl = (HtmlControl)Master.FindControl("liCommunications");

        if (cntrl != null)
        {
            cntrl.Attributes["class"] = "current_page_item";
        }//end menu controls


        //first time page loads
        if (!Page.IsPostBack)
        {
            //look for the qs id (commid)
            //if it is not null
            if (Request.QueryString["commid"] != null)
            {
                //switch datasource to the qs datasource
                gvCommunications.DataSourceID = dsCommunicationsQS.ID;

                //databind
                gvCommunications.DataBind();

                //Add this code if you add a ddl to filter communications
                //SelectedValue of the ddl to the qs value
                //DropDownListFor Communications.SelectedValue = Request.QueryString["commid"]

                //show the back button ONLY when arriving from the companies page via QueryString
                btnBackToJobPostings.Visible = true;
                
            }
            else if (Request.QueryString["contid"] != null)
            {
                //switch datasource to the qs datasource for contacts page
                gvCommunications.DataSourceID = dsCommunicationsQSContacts.ID;

                //databind
                gvCommunications.DataBind();

                ////Add this code if you add a ddl to filter communications
                ////SelectedValue of the ddl to the qs value
                //DropDownListForCommunications.SelectedValue = Request.QueryString["contid"];

                

                //show back button ONLY when arriving from companies page via QS
                btnBackToContacts.Visible = true;

            }
           



           
        }

    }
    protected void gvCommunications_SelectedIndexChanged(object sender, EventArgs e)
    {
        mvCommunications.ActiveViewIndex = 1;
    }
    protected void btnBackToCommunications_Click(object sender, EventArgs e)
    {
        
        mvCommunications.ActiveViewIndex = 0;
    }
    protected void btnAddNewCommunication_Click(object sender, EventArgs e)
    {
        dvSelectedCommunication.ChangeMode(DetailsViewMode.Insert);
        mvCommunications.ActiveViewIndex = 1;
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        //send user back to gridview when hit cancel button
        mvCommunications.ActiveViewIndex = 0;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        //send the user back to the gridview when hit insert button
        mvCommunications.ActiveViewIndex = 0;

        //databind 
    }
    protected void dsSelectedCommunication_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //once inserted, send user back to gridview
        mvCommunications.ActiveViewIndex = 0;

        //update the gridview
        gvCommunications.DataBind();

    }
    protected void LinkButton1_Click1(object sender, EventArgs e)
    {
        //when the user hits update send them back to the gridview
        mvCommunications.ActiveViewIndex = 0;
    }
    protected void dsSelectedCommunication_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        //once updated, send user back to gridview
        mvCommunications.ActiveViewIndex = 0;

        //update the gridview
        gvCommunications.DataBind();

    }

   protected void  btnBackToJobPostings_Click(object sender, EventArgs e)
    {
            Response.Redirect("~/JobPostings.aspx");

     }
    //*********SECURITY ADMIN*************

    //secure the LAST COLUMN of the Gridview
    protected void gvCommunications_DataBound(object sender, EventArgs e)
    {
        //hide the change status if the user is not an admin
        if (!User.IsInRole("admin"))
        {
            //index is 0 base
            gvCommunications.Columns[gvCommunications.Columns.Count - 1].Visible = false;
        }
    }

    //secure the LAST ROW of the DetailsView
    protected void dvSelectedCommunication_DataBound(object sender, EventArgs e)
    {
        if (!User.IsInRole("admin"))
        {
            dvSelectedCommunication.Rows[dvSelectedCommunication.Rows.Count - 1].Visible = false;
        }
    }

    //*********SECURE ADMIN BUTTONS OUTSIDE OF CONTROLS*********
    //and inside of a FV/ListView/datalist

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





    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Contacts.aspx");

    }
    //protected void ddlCompanies_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //if the selectedIndex = 0, use the dsForGvCommunications for the gridView
    //    if (ddlJobPostings.SelectedIndex == 0)
    //    {
    //        //assign the gv dsID property
    //        gvCommunications.DataSourceID = dsForGvCommunications.ID;

    //        //bind the data to the gv
    //        gvCommunications.DataBind();

    //    }
    //      //else use the dsCommunicationsByJobPosting
    //   else
    //   {
    //       gvCommunications.DataSourceID = dsCommunicationsByJobPostings.ID;

    //        //bind the data to the gv
    //       gvCommunications.DataBind();
    //   }

    //}
    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        //send user back to gridview when hit Cancel
        mvCommunications.ActiveViewIndex = 0;
    }
    protected void ddlJobPostings_SelectedIndexChanged(object sender, EventArgs e)
    {

        //if the selectedIndex = 0, use the dsForGvCommunications for the gridView
        if (ddlJobPostings.SelectedIndex == 0)
        {
            //assign the gv dsID property
            gvCommunications.DataSourceID = dsForGvCommunications.ID;

            //bind the data to the gv
            gvCommunications.DataBind();

        }//end if
        //else use the dsCommunicationsByJobPosting
        else
        {
            //assign the gv dsID property
            gvCommunications.DataSourceID = dsCommunicationsByJobPostings.ID;

            //bind the data to the gv
            gvCommunications.DataBind();
        }//end else
    }//end ddlJobPostings_SelectedIndexChanged
}