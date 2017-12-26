doc.xpath("//*[@id="content-column"]/div[5]/div/ul/li[1]/a/div/div/h3").text
@description ||= doc.xpath("//div[@class='c-8 nl nt']/p[3]").text
