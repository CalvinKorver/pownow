from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings
from pownow.spiders.squaw_spider import SquawSpider

process = CrawlerProcess(get_project_settings())
process.crawl(SquawSpider)
process.start()
