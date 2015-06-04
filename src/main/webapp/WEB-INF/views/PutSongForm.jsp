<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
  <title>
    update song
  </title>
    <link rel="stylesheet" href="../../mystyle.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>


    <h3>Update Song</h3>

<form:form method="PUT" action="/songCollection/${map.idCollection}/songs/${map.song.getId()}">
  <table>
    <tr>

      <td> Name <input type="text" name="name" value="${map.song.getName()}"/></td>
       <td> Band <input type="text" name="band" value="${map.song.getBand()}"/></td>
        <td><input type="submit" value="Submit" /></td>

      <td><button id="delete" type="button" value="${map.song.getId()}"> Delete</button></td>
    </tr>
  </table>
</form:form>
    <script>
        $("#delete").click(function(e){

            $.ajax({
                url: '/songCollection/${map.idCollection}/songs/${map.song.getId()}',
                type: 'DELETE',
                success: function(result) {
                    window.location.href ='/songCollection/${map.idCollection}/songs/'
                }
            });
        });
    </script>

</body>
</html>
