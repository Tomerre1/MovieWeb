from django.shortcuts import render
from myfile.models import File
from sendPdfs.models import mergedFile
from login.views import getNowUser
from django.contrib import messages
import os
import datetime
from threading import Timer


def home(request):
    user=(getNowUser())
    return render(request,'users/client.html',{'user':user})

def addFileButton(request):
    user=(getNowUser())
    fileInput = request.FILES.getlist('fileInput')
    for textFile in fileInput:
        fullName=textFile._name
        txt_name=fullName.split(".")[0]
        file=File(name=txt_name,file=textFile,user=(user.userName))
        file.save()
    messages.success(request, 'Uploaded successfully, Click to upload more')
    return render(request, 'users/client.html',{'user':user})

def deleteFile(request,id):
    deleteFile = File.objects.get(id=id)
    deleteFile.delete()
    return uploadFile(request)

def deleteDB(request):
    myFiles = File.objects.all()
    myFiles.delete()
    myFiles = mergedFile.objects.all()
    myFiles.delete()
    return render(request,'uploaded.html')


def uploadFile(request):
    user = (getNowUser())
    myFiles = File.objects.filter(user=user.userName)
    return render(request,'upload.html',{'files':myFiles,'user':user})

def uploadedFile(request):
    user = (getNowUser())
    myFiles = mergedFile.objects.filter(user=user.userName)
    return render(request,'uploaded.html',{'files':myFiles,'user':user})


