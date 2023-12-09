<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
        <title>Welcome to Shoo</title>
		<style>
		body {
            margin: 0;
            padding: 0;
            font-family: 'Tahoma', sans-serif;
            background-color: #d9edfa;
            color: #fff;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100vh;
        }
        h1 {
            text-align: center;
            padding: 20px;
            background: linear-gradient(to right, #4ab1a8, #182848);
            margin: 0;
            font-size: 2em;
            opacity: 0;
            animation: fadeIn 2s forwards;
        }

        p1{
            text-align: center;
            padding: 10px;
            margin: 0;
            font: "Rockwell";
            color: black;
            font-weight: bold;

        
        }

        h2 {
            text-align: center;
            margin: 20px 0;
            font-size: 1.5em;
        }
		b{
			position: relative;
			text-align: right;
			bottom: 470px;
			margin: 20px 0;
			font-size: 1.5em;
            color: black;
		}

        a {
            text-decoration: none;
            color: #fff;
            padding: 10px 20px;
            background-color: #4CAF50;
            border-radius: 5px;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        a:hover {
            background-color: #45a049;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        .gif-container {
            position: absolute;
            max-width: 30%; 
        }
    </style>
</head>
<body>

<h1 align="center">Welcome to Shoo</h1>



<h2 align="center"><a href="listprod.jsp?productName=&categoryId=0">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>


<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

<h4 align="center"><a href="ship.jsp?orderId=1">Test Ship orderId=1</a></h4>

<h4 align="center"><a href="ship.jsp?orderId=3">Test Ship orderId=3</a></h4>

<b><a href="login.jsp">Login</a><a href="logout.jsp">Log out</a></b>

<div class="gif-container">
    <img src="https://media2.giphy.com/media/3oEjHW5ZfmQsI2rUuk/giphy.gif?cid=ecf05e47bswf3swzoq97g950iskqa8ee9c0b2svhfa255ges&ep=v1_gifs_search&rid=giphy.gif&ct=g" alt="Animated GIF" style="width: 100%; height: auto;">
</div>
</body>
</head>


