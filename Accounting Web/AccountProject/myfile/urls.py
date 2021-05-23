from django.urls import path
from django.conf.urls import url,include
from myfile import views
from django.views.generic import TemplateView
app_name="myfile"
urlpatterns = [
    path('home', views.home,name='home'),
    path('upload', views.uploadFile,name='uploadfile'),
    path('uploaded', views.uploadedFile,name='uploadedfile'),
    path('addFileButton', views.addFileButton,name='addFileButton'),
    path('deleteDB', views.deleteDB,name='deleteDB'),
    url(r'^deleteFile/(?P<id>[0-9]+)/$', views.deleteFile,name='deleteFile'),
]