
package com.aisino.grain.webservice;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.aisino.grain.webservice package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _SaveOrUpdateGrainDepotInfoResponse_QNAME = new QName("http://webservice.grain.aisino.com/", "saveOrUpdateGrainDepotInfoResponse");
    private final static QName _SaveOrUpdateGrainDepotInfo_QNAME = new QName("http://webservice.grain.aisino.com/", "saveOrUpdateGrainDepotInfo");
    private final static QName _SaveOrUpdateGrainDepotInfoJsonData_QNAME = new QName("", "jsonData");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.aisino.grain.webservice
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link SaveOrUpdateGrainDepotInfo }
     * 
     */
    public SaveOrUpdateGrainDepotInfo createSaveOrUpdateGrainDepotInfo() {
        return new SaveOrUpdateGrainDepotInfo();
    }

    /**
     * Create an instance of {@link SaveOrUpdateGrainDepotInfoResponse }
     * 
     */
    public SaveOrUpdateGrainDepotInfoResponse createSaveOrUpdateGrainDepotInfoResponse() {
        return new SaveOrUpdateGrainDepotInfoResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SaveOrUpdateGrainDepotInfoResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webservice.grain.aisino.com/", name = "saveOrUpdateGrainDepotInfoResponse")
    public JAXBElement<SaveOrUpdateGrainDepotInfoResponse> createSaveOrUpdateGrainDepotInfoResponse(SaveOrUpdateGrainDepotInfoResponse value) {
        return new JAXBElement<SaveOrUpdateGrainDepotInfoResponse>(_SaveOrUpdateGrainDepotInfoResponse_QNAME, SaveOrUpdateGrainDepotInfoResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link SaveOrUpdateGrainDepotInfo }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://webservice.grain.aisino.com/", name = "saveOrUpdateGrainDepotInfo")
    public JAXBElement<SaveOrUpdateGrainDepotInfo> createSaveOrUpdateGrainDepotInfo(SaveOrUpdateGrainDepotInfo value) {
        return new JAXBElement<SaveOrUpdateGrainDepotInfo>(_SaveOrUpdateGrainDepotInfo_QNAME, SaveOrUpdateGrainDepotInfo.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link byte[]}{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "", name = "jsonData", scope = SaveOrUpdateGrainDepotInfo.class)
    public JAXBElement<byte[]> createSaveOrUpdateGrainDepotInfoJsonData(byte[] value) {
        return new JAXBElement<byte[]>(_SaveOrUpdateGrainDepotInfoJsonData_QNAME, byte[].class, SaveOrUpdateGrainDepotInfo.class, ((byte[]) value));
    }

}
