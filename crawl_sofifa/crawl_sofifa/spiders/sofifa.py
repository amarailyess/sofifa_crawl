import scrapy
import requests
from bs4 import BeautifulSoup
import requests
from bs4 import BeautifulSoup as bts
import pandas as pd
import re
import numpy as np
import time
import sys
import glob
import csv

class SofifaSpider(scrapy.Spider):
    name = 'sofifa'
    allowed_domains = ['sofifa.com']
    start_urls = ['http://sofifa.com/']
    players = []


    def start_requests(self):
        path= '/home/databiz33/Documents/31_01/pages/*'
        urls=glob.glob(path)
        for url in urls:
            link= 'file://'+url
            #print("link: ",link)
            yield scrapy.Request(url=link,callback=self.parse)

    def parse(self, response):
        header = []
        header.append(response.xpath('//tr[@class="persist-header"]/th/text()').extract_first())
        liste_header = response.xpath('//tr[@class="persist-header"]/th/a/text()').extract()
        for item in liste_header:
            header.append(item)

        soup = bts(response.text, "html.parser")
        table = soup.find("table")
        for row in table.find_all("tr")[1:]:
            cols = row.find_all("td")
            player = {"name": cols[1].get_text().strip()} # Oyuncunun adını al ve dictionary olarak tut
            for col in cols[2:]: # Oyuncunun adından sonraki tüm sütunları dolaş
                header = table.find_all("th")[cols.index(col)].get_text().strip() # Sütun başlığını al
                player[header] = col.get_text().strip() # Sütun değerini al ve oyuncu bilgilerine ekle
            self.players.append(player)
        #time.sleep(1)
        df = pd.DataFrame(self.players)
        df.to_csv("data.csv",sep=";",quoting=csv.QUOTE_ALL, encoding='utf-8', index=False)
        