from django.shortcuts import render
from myfile.models import File
from sendPdfs.models import mergedFile
from django.conf import settings
from django.core.mail import EmailMessage
from PyPDF2 import PdfFileMerger
import os
import datetime
import time
from twilio.rest import Client

def sendMail(nameFile,user):
    email = EmailMessage('Monthly Merged pdfs', f'Hi {user.userName},Sent your merged pdfs to email.', settings.EMAIL_HOST_USER, [user.email, ])
    email.attach_file(f'MergedPdfs\{nameFile}.pdf') 
    email.send()

def mergePdfs(user):
    closeMe = []
    nameFile="mergedFile"+str(datetime.datetime.now().date())
    x = [a for a in os.listdir('media/') if a.endswith(".pdf")]
    merger = PdfFileMerger()
    for pdf in x:
        y = open(f'media/{pdf}','rb')
        closeMe.append(y)
        merger.append(y)
    with open(f"MergedPdfs/{nameFile}.pdf", "wb") as fout:
        merger.write(fout)
    for pdf in closeMe:
        pdf.close()    
    for pdf in x:
        os.remove(f'media/{pdf}')      
    mergeFile=mergedFile(user=user.userName,name=nameFile,file=f'MergedPdfs/{nameFile}.pdf' )
    mergeFile.save()
    myFiles = File.objects.filter(user=user.userName)
    myFiles.delete()
    return nameFile

def sendWhatsapp(user):
    client = Client("ACc4fc9940599aafbc4b4a55a147271477","278416c2ddb8b1b72eb4a3bcafcdbac5")
    from_whatsapp_number='whatsapp:+14155238886'
    to_whatsapp_number = 'whatsapp:' + user.phoneNumber
    client.messages.create (body=f'Your documents has been sent to your Email: {user.email} by client: {user.userName}',
                            from_=from_whatsapp_number,
                            to=to_whatsapp_number)

def mergeAndSend(user):
    flag = True
    while True:
        if flag:
            flag = False
            if File.objects.filter(user=user.userName):
                if datetime.datetime.today().day == 19:  
                    sendWhatsapp(user) 
                    nameFile=mergePdfs(user)
                    sendMail(nameFile,user) 
        else:
            flag=True
            time.sleep((24*60*60))
