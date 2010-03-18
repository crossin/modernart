from django.template import RequestContext
from django.http import HttpResponse
from django.utils import simplejson
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response

from django.views.generic.simple import direct_to_template
from user_logic.gamelogic import *;
import datetime


    
def deal( request, template='deal.html'):
    DealButton();
    return render_to_response(template, context_instance=RequestContext(request));
    
def repurchase( request, template='repurchase.html'):
    RepurchaseButton();
    return render_to_response(template, context_instance=RequestContext(request));