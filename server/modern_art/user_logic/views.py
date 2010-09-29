# -*- coding: utf-8 -*-

from django.conf        import settings;
from django.core.urlresolvers   import reverse;
from django.http        import *;
from django.template    import RequestContext;
from django.template.loader     import render_to_string;
from django.utils.translation   import ugettext as _;
from django.utils       import simplejson;
from django.shortcuts   import render_to_response as rtr;
from django.contrib.auth.decorators import login_required;
from django.shortcuts   import get_object_or_404;

from datetime   import *;
from models     import *;
from decorators import *;

import random;
import logging;
import time;
from data import *;
  

def setup_initial_data( request,  template='default.html', extra_context=None):
    context = RequestContext(request);

    for p in iplayers:
        p.save();
    for c in icards:
        c.save();
    for ac in iAuctionCenters:
        ac.save();
    for rp in iRepurchasePrices:
        rp.save();
    context['msg'] = 'Initial Data Setup successfully';
    return rtr( template, context, context_instance=extra_context, mimetype="application/xhtml+xml")



