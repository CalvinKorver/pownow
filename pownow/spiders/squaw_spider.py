import scrapy


class SquawSpider(scrapy.Spider):
    name = "squaw"

    def start_requests(self):
        start_urls = [
            'https://squawalpine.com/mountain-information/real-time-lift-grooming-status'
        ]

        for url in start_urls:
            yield scrapy.Request(url=url, callback=self.parse)


    # Handle the response downloaded for each of the requests made
    def parse(self, response):
        lifts = {}
        liftDivs = response.xpath('//div[@id="squaw-lifts"]/div/div/div/div/div[has-class("row")]')
        for lift in liftDivs:
            lift_details = lift.xpath('div/text()')
            lift_name = lift_details[0].get()
            if len(lift_details) < 3:
                lift_wait = lift.xpath('div/text()')[1].get()
            else:
                lift_wait = lift.xpath('div/text()')[2].get()
            lift_status = self.parse_status(self, text=lift.xpath('div/span/span').get())
            lifts[lift_name] = {
                'status': lift_status,
                'wait': lift_wait
            }
        return lifts

    @staticmethod
    def parse_status(self, text):
        if 'close' in text:
            status = 'closed'
        elif 'open' in text:
            status = 'open'
        elif 'scheduled' in text:
            status = 'scheduled'
        elif 'hold' in text:
            status = 'hold'
        else:
            status = 'unknown'
        return status

