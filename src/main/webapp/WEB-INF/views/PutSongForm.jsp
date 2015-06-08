<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
  <title>
    update song
  </title>
    <%@include file="header.jsp" %>

</head>
<body>
<%@include file="bar.jsp" %>
    <h3>Update Song</h3>

<form:form method="PUT" action="/songCollection/${map.idCollection}/songs/${map.song.getId()}">
  <table align="center">
      <tr>
            <td>Name:</td>
      </tr>
      <tr>
            <td><input type="text" name="name" value="${map.song.getName()}"/></td>
      </tr>
      <tr>
        <td>Band:</td>
      </tr>
      <tr>
            <td><input type="text" name="band" value="${map.song.getBand()}"/></td>
      </tr>
  </table>
        <div style="text-align: center" >
            <input type="button" class="btn btn-primary"  value="edit" />
            <button id="delete" type="button" class="btn btn-danger" style="margin: 2px" value="${map.song.getId()}">Delete</button>
        </div>

</form:form>
    <script>
        $("#delete").click(function(e){

            $.ajax({
                url: '/songCollection/${map.idCollection}/songs/${map.song.getId()}',
                type: 'DELETE',
                success: function(result) {
                    window.location.href ='/songCollection/${map.idCollection}'
                }
            });
        });
    </script>

</body>
</html>
