from django.db import models

# Create your models here.
class mergedFile (models.Model):
   user = models.CharField(max_length=100)
   name = models.CharField(max_length=100)
   file = models.FileField(upload_to='MergedPdfs/')
   date = models.DateField(auto_now_add=True)
