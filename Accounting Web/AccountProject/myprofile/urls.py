from django.urls import path
from django.conf.urls import url,include
from myprofile import views
from django.views.generic import TemplateView
app_name="myprofile"
urlpatterns = [
    path('', views.myprofile,name='myprofile'),
    path('editprofile', views.editprofile,name='editprofile'),
    path('editprofilesubmit', views.editprofilesubmit,name='editprofilesubmit')
    
]