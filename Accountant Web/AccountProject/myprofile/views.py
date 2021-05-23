from django.shortcuts import render
from django.http import HttpResponse
from login.models import User
from login.views import getNowUser


# Create your views here.
def myprofile(request):
    user=(getNowUser())
    return render(request,f'myprofile.html',{'user':user}) 

def editprofilesubmit(request):
    user=(getNowUser())
    user.firstName=request.POST['firstName']
    user.lastName=request.POST['lastName']
    user.password=request.POST['password']
    user.email=request.POST['Email']
    user.phoneNumber=request.POST['phoneNumber']
    user.save()
    return render(request,f'myprofile.html',{'user':user})

def editprofile(request):
    user=(getNowUser())
    return render(request,'editprofile.html',{'user':user})

