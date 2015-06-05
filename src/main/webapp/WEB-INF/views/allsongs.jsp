<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: davidkaste
  Date: 23/02/15
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--<html>
<head>
    <title>Song list</title>



</head> -->
 <div>


        <c:if test="${not empty map.songs}">
            <h2> Songs </h2>
        <table class="table table-striped">
         <tr>
             <th>
                 Band

             </th>
             <th>
                 Name
             </th>
             <th>
                 edit
             </th>

         </tr>
            <c:forEach var="song" items="${map.songs}">
                <tr>
                    <td> ${fn:escapeXml(song.getBand())} </td>
                    <td><a href="/songCollection/${map.idCollection}/songs/${song.getId()}"> ${fn:escapeXml(song.getName())}</a>: </td>


                    <td><a href="/songCollection/${map.idCollection}/songs/${song.getId()}/form">Edit Song</a> </td>

                </tr>
            </c:forEach>
        </c:if>

    </table>
     <br>
            <div style="text-align: center" >
        <a type="button" class="btn btn-primary"  href="/songCollection/${map.idCollection}/songs/form">Search Song</a>
                </div>


</div>
<!--</html> -->
