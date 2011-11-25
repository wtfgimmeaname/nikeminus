module NikeMinus
  class Xml
    URL      = "http://nikerunning.nike.com"
    FILEPATH = "/nikeplus/v1/services/widget/get_public_run_list.jsp"
    URLPARAM = "?userID="
    FULLPATH = [URL, FILEPATH, URLPARAM].join("")

    def generate_xml(nike_id)
      url    = FULLPATH+nike_id
      xml  ||= Curl::Easy.perform(url).body_str rescue nil
      xmldoc = Nokogiri::XML(xml)
    end

    def valid_xml?(xmldoc)
      status = xmldoc.xpath("//plusService//status").text
      return false if status.include?("failure") || status.empty?
    end

    def save_xml(xml)
      if valid_xml?(xml)
    end
  end
end
