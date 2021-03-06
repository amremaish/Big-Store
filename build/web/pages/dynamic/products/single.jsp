
<%@page import="com.software.team.BigStore.Controllers.UserController"%>
<%@page import="java.io.IOException"%>
<%@page import="com.software.team.BigStore.Controllers.ProductController"%>
<%@page import="com.software.team.BigStore.model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/pages/header.jsp" %>

<!-- //navigation -->
<!-- breadcrumbs -->

<%! User user = new User();%>
<% if (session.getAttribute("normal") != null) {
        user = (User) session.getAttribute("normal");
        request.setAttribute("user", user);
    } else if (session.getAttribute("company") != null) {
        user = (User) session.getAttribute("company");
        request.setAttribute("user", user);
    } else {
        response.sendRedirect("../home/index.jsp");
    }%>

<%
    int pro_id = Integer.parseInt(request.getParameter("product_id"));

    Product p = new ProductController().getProudct(pro_id);
%>

<div class="breadcrumbs">
    <div class="container">
        <ol class="breadcrumb breadcrumb1 animated wow slideInLeft" data-wow-delay=".5s">
            <li><a href="/SoftwareProject/pages/dynamic/home/index.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a></li>
            <li class="active"><%= p.getProduct_name()%></li>
        </ol>
    </div>
</div>
<!-- //breadcrumbs -->
<div class="products">
    <div class="container">
        <%if (p.getOwner().getUser_id() == user.getUser_id()) {%>
        <h4 class="m-sing"><img height="30" width="30" alt="<%=p.getOwner().getUser_name()%> photo"  src="../jspfragments/retrive_image.jsp?userId=<%=p.getOwner().getUser_id()%>"/> <a href="/SoftwareProject/pages/dynamic/profile/profile.jsp"><%=p.getOwner().getUser_name()%></a></h4>
            <%} else {%>
        <h4 class="m-sing"><img height="30" width="30" alt="<%=p.getOwner().getUser_name()%> photo"  src="../jspfragments/retrive_image.jsp?userId=<%=p.getOwner().getUser_id()%>"/><a href="/SoftwareProject/pages/dynamic/profile/profile.jsp?visited_user=<%=p.getOwner().getUser_id()%>"><%=p.getOwner().getUser_name()%></a></h4>
            <%}%>
        <br/>
        <p class='date'><%=p.getPost_date()%></p>
        <div class="agileinfo_single">
            <div class="col-md-4 agileinfo_single_left">
                <img id="example" src="/SoftwareProject/pages/dynamic/jspfragments/retrive_image.jsp?imgId=<%=p.getProduct_id()%>" alt=" " class="img-responsive">
            </div>
            <div class="col-md-8 agileinfo_single_right">
                <h2><%=p.getProduct_name()%></h2>
                <div class="rating1">
                    <span class="starRating">
                        <% for (int i = 5; i > 0; i--) {
                                if (i == p.getProduct_rate()) {
                                    out.print("<input id=\"rating" + i + "\" type=\"radio\" name=\"rating\" value=" + i + " checked=\" \"><label for=\"rating" + i + "\">" + i + "</label>");
                                } else {
                                    out.print("<input id=\"rating" + i + "\" type=\"radio\" name=\"rating\" value=" + i + "><label for=\"rating" + i + "\">" + i + "</label>");
                                }
                            }
                        %>
                    </span>
                </div>
                <div class="w3agile_description">
                    <h4>Description :</h4>
                    <p><%=p.getProduct_details()%>.</p>
                </div>
                <div class="snipcart-item block">
                    <div class="snipcart-thumb agileinfo_single_right_snipcart">
                        <h4 class="m-sing">$ <%=p.getProduct_price()%><span>$ <%= p.getProduct_price() + (p.getProduct_price() / 5)%> </span>&nbsp;&nbsp; Expires at <%=p.getExpiry_date()%> </h4>
                    </div>
                    <h4> <img height="30" width="30" alt="<%=p.getProduct_category().getCat_name()%> photo"  src="../jspfragments/retrive_image.jsp?catId=<%=p.getProduct_category().getSub_cat_id()%>"/><a id='product_cat' href="/SoftwareProject/pages/dynamic/products/products.jsp?subcat=<%=p.getProduct_category().getSub_cat_id()%>"><%=p.getProduct_category().getCat_name()%></a></h4>
                    <br/>
                    <div class="snipcart-details agileinfo_single_right_details">
                        <form action="#" method="post">
                            <fieldset>
                                <input type="hidden" name="cmd" value="_cart">
                                <input type="hidden" name="add" value="1">
                                <input type="hidden" name="business" value=" ">
                                <input type="hidden" name="item_name" value="pulao basmati rice">
                                <input type="hidden" name="amount" value="21.00">
                                <input type="hidden" name="discount_amount" value="1.00">
                                <input type="hidden" name="currency_code" value="USD">
                                <input type="hidden" name="return" value=" ">
                                <input type="hidden" name="cancel_return" value=" ">
                                <input type="submit" name="submit" value="Add to cart" class="button">
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>

<!-- social div -->
<div class="breadcrumbs" style="width: 100%;">
    <h3>Top Comments</h3><br/>

    <!-- comments -->
    <div style="align-content: center;align-self: center;width: 100%;">
        <jsp:include page="CommentFragment.jsp" >
            <jsp:param name="pro_id" value="<%=p.getProduct_id()%>" />
        </jsp:include>
    </div>

    <!-- add comment -->
    <div class="login-form-grids animated wow slideInUp" data-wow-delay=".5s">
        <form action="http://localhost:8080/SoftwareProject/CommentServlet" method="post">
            <input type="text" placeholder=" Put Your comment " class="button" name="doComment">
            <%request.getSession().setAttribute("product_idobject", p.getProduct_id());%>
            <input type="submit" value="Comment"  class="button" >
        </form>
    </div>
</div>

<!-- new -->
<div class="newproducts-w3agile">
    <div class="container">
        <h3>New offers</h3>
        <div id="myTabContent" class="tab-content">
            <div role="tabpanel" class="tab-pane fade in active" id="expeditions1" aria-labelledby="expeditions-tab">
                <!-- load all recommended products in this section of home page -->
                <div class="agile_top_brands_grids" style="overflow:scroll;white-space: nowrap;height:450px;">
                    <%@include file="/pages/dynamic/jspfragments/productjsp/allproducts.jsp" %>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //new -->

<%@include file="/pages/footer.jsp" %>
