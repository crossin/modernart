from django.template import RequestContext
from django.http import HttpResponse
from django.utils import simplejson
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response

from django.views.generic.simple import direct_to_template
from user_logic.gamelogic import *;
import datetime;
import logging;
    
def deal( request, template='deal.html'):
    DealButton();
    return render_to_response(template, context_instance=RequestContext(request));
    
def repurchase( request, template='repurchase.html'):
    RepurchaseButton();
    return render_to_response(template, context_instance=RequestContext(request));
    
def login( request, template='login.html'):
    if request.method == 'POST':
        account  = request.POST['account'] 
        return render_to_response("ma.html", { 'id': account,})
    return render_to_response(template, context_instance=RequestContext(request));
	
def crossdomain( request, template='crossdomain.xml'):
    return render_to_response(template, context_instance=RequestContext(request));
    
def deal_job( request, template='default.html'):
    context = RequestContext(request);
    now=datetime.datetime.now()
    logging.info('RUNNING DEAL JOB -------------------');
    DealButton();
    logging.info('END DEAL JOB -----------------------');
    context['msg'] = 'JOB FINIESHED SUCCESSFULLY';
    return render_to_response(template, context);


def repurchase_job( request, template='default.html'):
    context = RequestContext(request);
    now=datetime.datetime.now()
    logging.info('RUNNING repurchase JOB -------------------');
    RepurchaseButton();
    logging.info('END repurchase JOB -----------------------');
    context['msg'] = 'JOB FINIESHED SUCCESSFULLY';
    return render_to_response(template, context);