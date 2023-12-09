<style>
    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        background: linear-gradient(to right, #4ab1a8, #182848);
        margin: 0;
        font-size: 1.5em;
        opacity: 0;
        animation: fadeIn 2s forwards;
        color: white; /* Header text color */
    }

    .header-container h1 {
        margin: 0;
    }

    .signed-in-container {
        text-align: center;
        margin: 10px 0;
        font-size: 1.0em;
        color: black; /* "Signed in as" text color */
    }

    hr {
        color: red;
    }

    @keyframes fadeIn {
        to {
            opacity: 1;
        }
    }
</style>

<div class="header-container">
    <h1 class="custom-button" onclick="location.href='index.jsp';"><a href="index.jsp">Shoo</a></h1>
    <div class="signed-in-container">
        <%
            String userName = (String) session.getAttribute("authenticatedUser");
            if (userName != null) {
                out.println("Signed in as: " + userName);
            }
        %>
    </div>
</div>

<hr>
