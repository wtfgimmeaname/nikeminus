module NikeMinus
  class XML
    URL      = "http://nikerunning.nike.com"
    FILEPATH = "/nikeplus/v1/services/widget/get_public_run_list.jsp"
    URLPARAM = "?userID="
    FULLPATH = [URL, FILEPATH, URLPARAM].join("")

    def uid=(uid)
      @uid = uid
    end

    def save!
      return false if @uid.nil
    end

    def xmldoc
      url    = FULLPATH+uid
      xml  ||= Curl::Easy.perform(url).body_str rescue nil
      @xmldoc = Nokogiri::XML(xml)
    end

    def valid_xml?(xmldoc)
      status = xmldoc.xpath("//plusService//status").text
      return false if status.include?("failure") || status.empty?
    end

  end
end
