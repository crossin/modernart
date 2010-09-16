# -*- coding: utf-8 -*-
from django.db import models
from django.contrib.auth.models import User
import pyamf

import datetime

class AuctionCenter(models.Model):
    id              = models.AutoField(primary_key=True);
    max_player      = models.IntegerField( default = 0 )
    count_player    = models.IntegerField( default = 0 )
    phase           = models.IntegerField( default = 0 )
    name            = models.CharField(max_length=32)
    description     = models.CharField(max_length=255)

class Player(models.Model):
    id              = models.AutoField(primary_key=True);
    gold            = models.IntegerField( default = 0 )
    gold_frozen     = models.IntegerField( default = 0 )
    exp             = models.IntegerField( default = 0 )
    in_auction      = models.BooleanField( default = False )
    auctioncenter   = models.ForeignKey( AuctionCenter , null=True)
    max_card        = models.IntegerField( default = 10 )
    count_card      = models.IntegerField( default = 0 )
    name            = models.CharField(max_length=32)
    xn_id			= models.CharField(max_length=32)
    
class Card(models.Model):
    id              = models.AutoField(primary_key=True);
    card_class      = models.IntegerField( default = 0 )
    auction_type    = models.IntegerField( default = 0 )
    content         = models.IntegerField( default = 0 )
    name            = models.CharField(max_length=16)
    description     = models.CharField(max_length=255)
        
class Player_Card(models.Model):
    id              = models.AutoField(primary_key=True);
    player          = models.ForeignKey( Player )
    card            = models.ForeignKey( Card )   
    is_new          = models.BooleanField( default = False )
    is_bought       = models.BooleanField( default = False )
    
class Auction(models.Model):
    id              = models.AutoField(primary_key=True);
    owner           = models.OneToOneField( Player )
    card            = models.ForeignKey( Card )
    bidder          = models.ForeignKey( Player ,related_name = "bidder_id",null=True)
    auctioncenter   = models.ForeignKey( AuctionCenter )
    price           = models.FloatField( default = 0.0 )
    time_start      = models.DateTimeField( auto_now = False )
    time_latest     = models.DateTimeField( auto_now = False )
    count_bid       = models.IntegerField( default = 0 )

class Bid(models.Model):
    id              = models.AutoField(primary_key=True);
    auction         = models.ForeignKey( Auction ,related_name = "bid_auction")
    player          = models.ForeignKey( Player )
    price           = models.FloatField( default = 0.0 )
    
class RepurchasePrice(models.Model):
    id              = models.AutoField(primary_key=True);
    auctioncenter   = models.ForeignKey( AuctionCenter )
    card_class      = models.IntegerField( default = 0 )
    count           = models.IntegerField( default = 0 )
    price_1         = models.FloatField( default = 0.0 )
    price_2         = models.FloatField( default = 0.0 )
    price_3         = models.FloatField( default = 0.0 )
    price_4         = models.FloatField( default = 0.0 )
  
class PlayerLog(models.Model):
    id              = models.AutoField(primary_key=True);
    player          = models.ForeignKey( Player )
    time            = models.DateTimeField( auto_now = False )
    message         = models.CharField( max_length=200 )

