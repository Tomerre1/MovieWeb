function field_focus(field, email) {
    if (field.value == email) {
        field.value = '';
    }
}

function field_blur(field, email) {
    if (field.value == '') {
        field.value = email;
    }
}

//Fade in dashboard box
$(document).ready(function () {
    $('.box').hide().fadeIn(1000);
});

//Stop click event
$('a').click(function (event) {
    event.preventDefault();
});
/*<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title></title>
    <style>
        .seat {
            height: 20px;
            width: 20px;
            border: 1px solid gray;
            cursor: pointer;
            background-color: white;
        }

        .walk {
            padding-left: 20px;
        }

    </style>



</head>
<body>

    <div style="border:1px solid gray; width:130px;">
        <table>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
            <tr>
                <td><div class="seat"></div> </td>
                <td><div class="seat"></div></td>
                <td class="walk">  </td>
                <td><div class="seat"></div></td>
                <td><div class="seat"></div></td>
            </tr>
        </table>
    </div>


    <script>

        var allSeats = document.querySelectorAll('.seat');
          for (var i = 0; i < allSeats.length; i++) {
            var seat = allSeats[i];
            seat.addEventListener('click', function () {
                var bgclr = this.style.backgroundColor;
                if (bgclr == 'red')
                    this.style.backgroundColor = 'white';
                else
                    this.style.backgroundColor = 'red';
            }, false);
        }

    </script>


</body>
</html>*/