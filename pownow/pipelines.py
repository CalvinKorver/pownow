import boto3

# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


class PownowPipeline(object):

    def __init__(self, aws_access_key_id, region_name, aws_secret_access_key):
        self.aws_access_key_id = aws_access_key_id
        self.region_name = region_name
        self.aws_secret_access_key = aws_secret_access_key

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            aws_access_key_id=crawler.settings.get('AWS_ACCESS_KEY_ID'),
            aws_secret_access_key=crawler.settings.get('AWS_SECRET_ACCESS_KEY'),
            region_name=crawler.settings.get('REGION_NAME')
        )

    def open_spider(self, spider):
        self.client = boto3.client('dynamodb', aws_access_key_id=self.aws_access_key_id, aws_secret_access_key=self.aws_secret_access_key, region_name=self.region_name)

    def process_item(self, item, spider):
        for lift in item:
            print(item[lift]['status'])
            print('lift name: ' + lift)
            self.client.put_item(TableName='SquawLifts',
                                 Item={'LiftName': {'S': lift},
                                       'Status': {'S': item[lift]['status']}})

        return item


