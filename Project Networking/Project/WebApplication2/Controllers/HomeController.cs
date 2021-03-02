using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebApplication2.Models;
using WebApplication2.ViewModel;
using WebApplication2.Dal;
using System.Windows;
using System.Web.Mvc;
using WebApplication2;
using System.Data.SqlClient;

namespace WebApplication2.Controllers
{
    public class HomeController : Controller
    {

        public static User user = null;
        public static Boolean flag = false;
        public static int paypalPrice = 0; 

        public ActionResult Index() //Home Page
        { 
            return View(); 
        }
        public ActionResult SubmitLog() // Fucntion to check user validation and check if the user is admin
        {
            userViewModel cvm = new userViewModel();
            cvm.users = new List<User>();
            UserDal userDal = new UserDal();
            string user_name = Request.Form["UserName"];
            string password = Request.Form["UserPassword"];
            cvm.users = (from x in userDal.Users where x.UserName.Contains(user_name) select x).ToList<User>();
            if (cvm.users.Count == 0)
            {
                return View("Login");
            }
            else
            {
                User user2 = cvm.users.First();
                if (user2.UserPassword == password)
                {
                    if (user2.UserName == "admin")
                    {
                        user = user2;
                        return View("AdminDashboard", cvm);
                    }
                    else
                    {
                        user = user2;
                        return View("Index", cvm);
                    }
                }

                else
                    return View("Login");
            }
        }

        public ActionResult AdminDashboard()
        {
            return View();
        }

        public ActionResult submitMovie() // add new movie 
        {
            Movie newMovie = new Movie();
            movieDal mDal = new movieDal();
            newMovie.movieName = Request.Form["movieName"];
            newMovie.movie_description = Request.Form["movieDescription"];
            newMovie.price = int.Parse(Request.Form["Price"]);
            newMovie.age = int.Parse(Request.Form["Age"]);
            newMovie.category = Request.Form["Category"];
            newMovie.movie_image = Request.Form["MovieImg"];
            string str = Request.Form["SalePrice"];
            
            if (str == "")
            
                newMovie.prev_price = newMovie.price;
            
            else
            
                newMovie.prev_price = int.Parse(Request.Form["SalePrice"]);
            
            
            mDal.MoviesDB.Add(newMovie);
            mDal.SaveChanges();
            return AddRemoveMovie();
        }

        public ActionResult ManagePrices() // view price change for admin 
        {
            movieViewModel cvm = new movieViewModel();
            movieDal mDal = new movieDal();
            cvm.movie = new Movie();
            cvm.movies = new List<Movie>();
            cvm.movies = (from x in mDal.MoviesDB select x).ToList<Movie>();
            return View("ManagePrices", cvm);
        }


        public ActionResult ChangePrice(string myMovie) // update price for selected movie
        {
            movieViewModel cvm = new movieViewModel();
            movieDal mDal = new movieDal();
            Movie needUpdate = new Movie();
            cvm.movies = new List<Movie>();
            string price = Request.Form[myMovie].ToString();
            string[] priceArr = price.Split(',');
            int newPrice = int.Parse(priceArr[0]);
            needUpdate = (from x in mDal.MoviesDB where x.movieName.Contains(myMovie) select x).ToList<Movie>()[0];
            mDal.MoviesDB.Remove(needUpdate);
            mDal.SaveChanges();
            needUpdate.price = newPrice;
            mDal.MoviesDB.Add(needUpdate);
            mDal.SaveChanges();
            return ManagePrices();
        }
        public ActionResult AddMovie() {return View();} // just return the view that got form view to submit details

        public ActionResult AddRemoveMovie() // return view of remove\add movies  
        {

            movieViewModel cvm = new movieViewModel();
            movieDal mDal = new movieDal();
            cvm.movie = new Movie();
            cvm.movies = new List<Movie>();
            cvm.movies = (from x in mDal.MoviesDB select x).ToList<Movie>();
            return View("AddRemoveMovie",cvm);
        }


        public ActionResult RemoveMovieFromDB(string myMovie) // remove function for AddRemoveMovie view 
        {         
            movieDal mDal = new movieDal();
            Movie removeMe = new Movie();
            removeMe = (from x in mDal.MoviesDB where x.movieName.Contains(myMovie) select x).ToList<Movie>()[0];
            mDal.MoviesDB.Remove(removeMe);
            mDal.SaveChanges();
            return AddRemoveMovie();
        }


        public ActionResult SubmitBuy(string MyMovie) // function for button "submit" in moviePage View that redirect to MovieHall for choosing chairs
        {
           
            orderViewModel cvm = new orderViewModel();
            orderDal ordersDal = new orderDal();
            datesDal dDal = new datesDal();
            movieDal mDal = new movieDal();
            HallSeatsDal hDal = new HallSeatsDal();
            cvm.orders = new List<Order>();
            cvm.user = user;
            cvm.myMovie = (from x in mDal.MoviesDB where x.movieName.Contains(MyMovie) select x).ToList<Movie>()[0];
            string phrase = Request.Form["slct"];
            string[] time_date = phrase.Split(' ');
            cvm.date = time_date[0];
            cvm.time = time_date[1];
            string myHall = (from x in dDal.DatesDB where x.movie_date.Contains(cvm.date) && x.movie_time.Contains(cvm.time) && x.movieName.Contains(MyMovie) select x.hall).ToList<string>()[0];
            cvm.HallRows = new HallSeats();
            cvm.HallRows = (from x in hDal.HallSeatsDB where x.HallId.Contains(myHall) select x).ToList<HallSeats>()[0];
            cvm.hall = myHall;
            cvm.orders = (from x in ordersDal.OrdersDB where x.movie_date.Contains(cvm.date) && x.movie_time.Contains(cvm.time) && x.hallID.Contains(myHall) select x).ToList<Order>();
            return View("MovieHall", cvm);
        }

        public ActionResult Signup() // Regestrion for user
        {
            userViewModel myUser = new userViewModel();
            myUser.user = new User();
            myUser.user.FirstName = Request.Form["FirstName"];
            myUser.user.LastName = Request.Form["LastName"];
            myUser.user.UserID = Request.Form["userId"];
            myUser.user.UserName = Request.Form["userName"];
            myUser.user.UserPassword = Request.Form["UserPassword"];
            myUser.user.UserEmail = Request.Form["UserEmail"];
            myUser.user.UserPhone = Request.Form["UserPhone"];
            return View("Signup", myUser);

        }

        public ActionResult RemoveItem(string MyMovie, string date, string time, string oldSeats) // remove item from cart function 
        {
            Cart oldCart = new Cart();
            cartDal cDal = new cartDal();
            oldCart = (from x in cDal.CartDB where x.movie_date.Contains(date) && x.movie_time.Contains(time) && x.movieName.Contains(MyMovie) && x.userName.Contains(user.UserName) && x.Seats.Contains(oldSeats) select x).ToList<Cart>()[0];
            cDal.CartDB.Remove(oldCart);
            cDal.SaveChanges();

            cartViewModel cvm = new cartViewModel();
            cvm.user_carts = (from x in cDal.CartDB where x.userName.Contains(user.UserName) select x).ToList<Cart>();
            return View("Cart", cvm);
        }

        public ActionResult SubmitReg(User Details) // Validation while regesterion to check if the field its valid and if not add message with worng fields
        {
            UserDal userDal = new UserDal();
            userViewModel cvm = new userViewModel();
            if (ModelState.IsValid)
            {
                userDal.Users.Add(Details);
                userDal.SaveChanges();
                return View("Index");
            }
            else
            {
                cvm.user = Details;
                string messages = string.Join("", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));

                MessageBox.Show(messages + "\n Please Fix The Following Errors, You back to Signup page ");

            }
            cvm.users = userDal.Users.ToList<User>();
            return View("Signup", cvm);

        }

        public ActionResult changeHall() // view for change hall and if the show already started its will not appear.
        {
            datesViewModel cvm = new datesViewModel();
            cvm.movies_dates = new List<dates>();
            movieDal movieDal = new movieDal();
            datesDal dDal = new datesDal();
            cvm.movie = new Movie();
            cvm.movies_dates = dDal.DatesDB.ToList<dates>();
            foreach (dates data in cvm.movies_dates.ToList<dates>())
            {
                string[] y = data.movie_date.Split('-');
                string[] z = data.movie_time.Split(':');
                DateTime start = new DateTime(int.Parse(y[0]), int.Parse(y[1]), int.Parse(y[2]), int.Parse(z[0]), int.Parse(z[1]), 0);
                if (DateTime.Now > start) { cvm.movies_dates.Remove(data); }
            }
            return View("changeHall",cvm); 
        }

        public ActionResult changeHallFunc(string myMovie,string selectedHall,string movie_date,string movie_time) // function for change hall 
        {
            datesViewModel cvm = new datesViewModel();
            datesDal dDal = new datesDal();
            cvm.movies_dates = new List<dates>();
            string newHall = Request.Form[myMovie].ToString();
            if(int.Parse(newHall)<=0 || int.Parse(newHall) > 8)
            {
                MessageBox.Show("Hall cant be found");
                
            }
            else
            {
                dates hallNeedChange = (from x in dDal.DatesDB where x.movieName.Contains(myMovie) &&
                                                                     x.movie_date.Contains(movie_date)&&
                                                                     x.movie_time.Contains(movie_time) &&
                                                                     x.hall.Contains(selectedHall) select x).ToList<dates>().First<dates>();
                
                List <dates> check = (from x in dDal.DatesDB
                                      where   x.movie_date.Contains(movie_date) &&
                                              x.movie_time.Contains(movie_time) &&
                                            x.hall.Contains(newHall) select x).ToList<dates>().ToList<dates>();
                if (check.Count == 0 || (check.Count>0 && check.Contains(hallNeedChange)))
                {
                    dDal.DatesDB.Remove(hallNeedChange);
                    dDal.SaveChanges();
                    dates changedHall = new dates();
                    changedHall.hall = newHall;
                    changedHall.movieName = myMovie;
                    changedHall.movie_date = movie_date;
                    changedHall.movie_time = movie_time;
                    dDal.DatesDB.Add(changedHall);
                    dDal.SaveChanges();
                }
                else
                {
                    MessageBox.Show("Hall cant be changed , there is another show at the same time and the same date and the same hall!!!");
                }
            }           
            return changeHall();
        }

        public ActionResult Enter() //
        {
            UserDal userDal = new UserDal();
            userViewModel cvm = new userViewModel();
            List<User> users = userDal.Users.ToList<User>();
            cvm.user = new User();
            cvm.users = users;
            return View("Signup", cvm);
        }

        public ActionResult ConfrimBuyChairs(string movieName, string movie_date, string movie_time, string hallID) // function that get chairs that user ordered for specefic movie and make order of it in database
        {
            orderDal ordDal = new orderDal();
            string phrase = Request.Form["seats"];
            string[] chairs = phrase.Split(',');
            
            for (int i = 0; i < chairs.Length; i++)
            {
                Order ord = new Order();
                ord.movieName = movieName;
                ord.movie_date = movie_date;
                ord.movie_time = movie_time;
                ord.hallID = hallID;
                ord.chairID = chairs[i];
                ordDal.OrdersDB.Add(ord);
                ordDal.SaveChanges();
            }
            flag = false;
            movieDal mDal = new movieDal();
            int price4paypal = (from x in mDal.MoviesDB where x.movieName.Equals(movieName) select x.prev_price).ToList<int>()[0];
            paypalPrice = chairs.Length * price4paypal;

            return View("Payment");
        }

        public ActionResult PayAllCart()
        {
            flag = true;
            return View("Payment");
        }
        public ActionResult Login() // View of Login
        {
            return View();
        }
        [HttpPost]
        public ActionResult MovieHall() // View that show seats and if taken its will be gray and if not its will be white
        {
            orderDal ordersdals = new orderDal();
            orderViewModel cvm = new orderViewModel();
            List<Order> orders = ordersdals.OrdersDB.ToList<Order>();

            cvm.orders = orders;
            return View();
        }


        public ActionResult ManageHalls() // View for admin to change num of rows in each hall 
        {

            hallSeatsViewModel cvm = new hallSeatsViewModel();
            HallSeatsDal hDal = new HallSeatsDal();
            cvm.hall= new HallSeats();
            cvm.halls = new List<HallSeats>();
            cvm.halls = (from x in hDal.HallSeatsDB select x).ToList<HallSeats>();
            return View("ManageHalls", cvm);
        }

        public ActionResult ChangeHallSeats(string myHall) // function that update the number of rows in selected hall from admin
        {
            hallSeatsViewModel cvm = new hallSeatsViewModel();
            HallSeatsDal hDal = new HallSeatsDal();
            HallSeats needUpdate = new HallSeats();
            cvm.halls = new List<HallSeats>();
            string hallRows = Request.Form[myHall].ToString();
            needUpdate = (from x in hDal.HallSeatsDB where x.HallId.Contains(myHall) select x).ToList<HallSeats>()[0];
            hDal.HallSeatsDB.Remove(needUpdate);
            hDal.SaveChanges();
            needUpdate.numRows = hallRows;
            hDal.HallSeatsDB.Add(needUpdate);
            hDal.SaveChanges();
            return ManageHalls();
    }

        public ActionResult Payment() // return view of payment
        {

            return View("Payment");

        }

        public ActionResult ViewPayment() // function after payement that delete cart if needed and store the order if you bought it in order db
        {
           
            cartDal cDal = new cartDal();
            orderDal ordDal = new orderDal();
            if (flag)// to know if i come from confrim button or from cart button [delete or cart or not]
            {
                List<Cart> oldCart = new List<Cart>();
                oldCart = (from x in cDal.CartDB where x.userName.Contains(user.UserName) select x).ToList<Cart>();
                foreach (Cart x in oldCart.ToList() )
                {
                    foreach(string y in x.Seats.Split(','))
                    {
                        Order ord = new Order();
                        ord.movieName = x.movieName;
                        ord.movie_date = x.movie_date;
                        ord.movie_time = x.movie_time;
                        ord.hallID = x.hall;
                        ord.chairID = y;
                        ordDal.OrdersDB.Add(ord);
                        ordDal.SaveChanges();
                    }
                }
      
                foreach (Cart item in oldCart.ToList())
                {
                    cDal.CartDB.Remove(item);
                    cDal.SaveChanges();
                }
               
            }
            MessageBox.Show("Payment Accepted");

            /*  paymentDal pDal = new paymentDal();
                Payment MyPayment = new Payment();
                MyPayment.Name = Request.Form["Fname"];
                MyPayment.NumberCard = Request.Form["NoCard"];
                List<Payment> check = (from x in pDal.PaymentDB where x.NumberCard.Contains(MyPayment.NumberCard) select x).ToList<Payment>();
                if (check.Count == 0)
                {
                pDal.PaymentDB.Add(MyPayment);
                pDal.SaveChanges();
             }*/

            return View("Index");
           
        }

        public ActionResult addToCart(string movieName, string movie_date, string movie_time, string hallID, string userName, string price) //add item to cart of specefic user
        {
            cartDal cDal = new cartDal();
            cartViewModel cvm = new cartViewModel();
            cvm.cart = new Cart();
            cvm.cart.movieName = movieName;
            cvm.cart.movie_date = movie_date;
            cvm.cart.movie_time = movie_time;
            cvm.cart.hall = hallID;
            cvm.cart.userName = userName;
            cvm.cart.price = price;
            cvm.cart.Seats = Request.Form["seatsForCart"];
            cvm.cart.subTotal = Request.Form["subtotal"];
            cDal.CartDB.Add(cvm.cart);
            cDal.SaveChanges();
            return View("Index");
        }
        public ActionResult Cart() // show cart view
        {
            cartDal cDal = new cartDal();
            cartViewModel cvm = new cartViewModel();
            cvm.cart = new Cart();
            cvm.cart.userName = user.UserName;
            cvm.user_carts = (from x in cDal.CartDB where x.userName.Contains(cvm.cart.userName) select x).ToList<Cart>();
            return View("Cart", cvm);
        }

        public ActionResult addSeatChanges(string MyMovie, string userName, string date, string time, string hall, string price, string oldSeats) // function that change seats for user cart
        {
            cartDal cDal = new cartDal();
            Cart myCart = new Cart();
            myCart.movieName = MyMovie;
            myCart.userName = userName;
            myCart.movie_date = date;
            myCart.movie_time = time;
            myCart.Seats = Request.Form["seatsForCart"];
            myCart.subTotal = Request.Form["subtotal"];
            myCart.price = price;
            myCart.userName = user.UserName;
            myCart.hall = hall;

            Cart oldCart = new Cart();
            oldCart = (from x in cDal.CartDB where x.movie_date.Contains(date) && x.movie_time.Contains(time) && x.movieName.Contains(MyMovie) && x.userName.Contains(user.UserName) && x.Seats.Contains(oldSeats) select x).ToList<Cart>()[0];

            cDal.CartDB.Remove(oldCart);
            cDal.SaveChanges();

            cDal.CartDB.Add(myCart);
            cDal.SaveChanges();

            return View("Index");
        }

        public ActionResult ChangeYourSeats(string MyMovie, string userName, string date, string time, string hall, string price, string seats) // hall view for change seats
        {
            changeSeatsViewModel cvm = new changeSeatsViewModel();
            orderDal ordersDal = new orderDal();
            datesDal dDal = new datesDal();
            cvm.movieName = MyMovie;
            cvm.userName = userName;
            cvm.date = date;
            cvm.time = time;
            cvm.price = price;
            cvm.userName = user.UserName;
            cvm.newSeats = seats;
            HallSeatsDal hDal = new HallSeatsDal();
            cvm.hall = (from x in hDal.HallSeatsDB where x.HallId.Contains(hall) select x).ToList<HallSeats>().First(); 
            cvm.orders = (from x in ordersDal.OrdersDB where x.movie_date.Contains(cvm.date) && x.movie_time.Contains(cvm.time) && x.hallID.Contains(hall) select x).ToList<Order>();
            return View("ChangeYourSeats", cvm);
        }
        public ActionResult MovieGallery(string sort_Type) // gallery of movies with sorts
        {
            movieViewModel cvm = new movieViewModel();
            cvm.movies = new List<Movie>();
            movieDal movieDal = new movieDal();
            cvm.movie = new Movie();
            datesDal dDal = new datesDal();
            orderDal ordDal = new orderDal();
            if (sort_Type == "category")
            {
                string category_name = Request.Form["selectName"].ToString();
                cvm.movies = (from x in movieDal.MoviesDB where x.category.Contains(category_name) select x).ToList<Movie>();
            }

            else if (sort_Type == "most_popular")
            {
                List<MostPopularSortMovie> result = ordDal.OrdersDB.GroupBy(G => G.movieName).Select(e => new MostPopularSortMovie{
                   name = e.Key,
                   count = e.Count()
               }).ToList();

               result = result.OrderBy(x => x.count).ToList<MostPopularSortMovie>();
               result.Reverse();
                foreach (MostPopularSortMovie k in result)
                {
                    Movie m = (from x in movieDal.MoviesDB where x.movieName.Contains(k.name) select x).ToList<Movie>().First();
                    cvm.movies.Add(m);
                }
            }

            else if (sort_Type == "age")
            {
                cvm.movies = (from x in movieDal.MoviesDB where x.age >= 18 select x).ToList<Movie>();
            }


            else if (sort_Type == "price_decrease")
            {
                cvm.movies = (from x in movieDal.MoviesDB select x).ToList<Movie>();
                cvm.movies = cvm.movies.OrderBy(o => (o.prev_price)).ToList<Movie>();
                cvm.movies.Reverse();
            }
            else if (sort_Type == "price_increase")
            {
                cvm.movies = (from x in movieDal.MoviesDB select x).ToList<Movie>();
                cvm.movies = cvm.movies.OrderBy(o => (o.prev_price)).ToList<Movie>();
            }
            else if (sort_Type == "filter_price")
            {
                int price_selected = int.Parse(Request.Form["range-1a"]);

                cvm.movies = (from x in movieDal.MoviesDB where x.prev_price <= price_selected select x).ToList<Movie>();

            }
            else if (sort_Type == "date")
            {
                string date = Request.Form["MovieDate"].ToString();
                List<String> mNames = (from x in dDal.DatesDB where x.movie_date.Contains(date) select x.movieName).ToList<String>();
                cvm.movies = (from x in movieDal.MoviesDB where mNames.Contains(x.movieName) select x).ToList<Movie>();
            }
            else if (sort_Type == "hour")
            {

                string hour = Request.Form["hour"].ToString();
                List<String> mNames = (from x in dDal.DatesDB where x.movie_time.Contains(hour) select x.movieName).ToList<String>();
                cvm.movies = (from x in movieDal.MoviesDB where mNames.Contains(x.movieName) select x).ToList<Movie>();
            }
            else if(sort_Type == "Sales")
            {
                cvm.movies = (from x in movieDal.MoviesDB where (x.prev_price!=x.price) select x).ToList<Movie>().OrderBy(x=>x.prev_price).ToList<Movie>();                
            }
            else
            {
                cvm.movies = (from x in movieDal.MoviesDB select x).ToList<Movie>();
            }

            return View("MovieGallery", cvm);
        }

        public ActionResult moviePage(string movieName) // show movie page with information about the movie
        {
            datesViewModel cvm = new datesViewModel();
            cvm.movies_dates = new List<dates>();
            movieDal movieDal = new movieDal();
            datesDal dDal = new datesDal();
            cvm.movie = new Movie();
            cvm.movie = (from x in movieDal.MoviesDB where x.movieName.Contains(movieName) select x).ToList<Movie>()[0];

            cvm.movies_dates = (from x in dDal.DatesDB where x.movieName.Contains(movieName) select x).ToList<dates>();

            foreach (dates data in cvm.movies_dates.ToList<dates>())
            {
                string[] y = data.movie_date.Split('-');
                string[] z = data.movie_time.Split(':');
                DateTime start = new DateTime(int.Parse(y[0]), int.Parse(y[1]), int.Parse(y[2]), int.Parse(z[0]), int.Parse(z[1]), 0);
                if (DateTime.Now > start) 
                    cvm.movies_dates.Remove(data);
            }
            return View("moviePage", cvm);
        }
    }
}