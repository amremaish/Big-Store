package com.software.team.BigStore.DBServlets.UserServlets;

import com.software.team.BigStore.Controllers.UserController;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.software.team.BigStore.model.Company;
import com.software.team.BigStore.model.NormalUser;
import com.software.team.BigStore.model.User;
import java.util.List;
import javax.servlet.RequestDispatcher;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Saad
 */
public class CheckLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        UserController controller = new UserController();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(24*60*60);

        boolean submitted = false;

        int userid;

        userid = controller.getUserId(email, password);
        User u = controller.getUser(userid);

        if (userid >= 0) {
            if (u.getUserType() == 1) {

                Company company = controller.getCompany(userid);

                //transfer company user data through session
                session.setAttribute("company", company);

                //redirect to home page
                response.sendRedirect("/SoftwareProject/pages/dynamic/home/index.jsp");

                controller.commitChanges();
            } else if (u.getUserType() == 0) {

                NormalUser normal = controller.getNormal(userid);

                //transfer normal user data through session
                session.setAttribute("normal", normal);

                //redirect to home page
                response.sendRedirect("/SoftwareProject/pages/dynamic/home/index.jsp");

                controller.commitChanges();
            }
        } else {
            //redirect to login page
            response.sendRedirect("/SoftwareProject/pages/dynamic/userlogging/login.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
