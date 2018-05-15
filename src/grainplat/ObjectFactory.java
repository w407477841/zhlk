
package grainplat;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the grainplat package. 
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

    private final static QName _SaveOrUpdateGrainDepotInfoArgs0_QNAME = new QName("http://grainplat", "args0");
    private final static QName _SaveOrUpdateGrainDepotInfoArgs3_QNAME = new QName("http://grainplat", "args3");
    private final static QName _SaveOrUpdateGrainDepotInfoArgs4_QNAME = new QName("http://grainplat", "args4");
    private final static QName _SaveOrUpdateGrainDepotInfoArgs1_QNAME = new QName("http://grainplat", "args1");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: grainplat
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
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://grainplat", name = "args0", scope = SaveOrUpdateGrainDepotInfo.class)
    public JAXBElement<String> createSaveOrUpdateGrainDepotInfoArgs0(String value) {
        return new JAXBElement<String>(_SaveOrUpdateGrainDepotInfoArgs0_QNAME, String.class, SaveOrUpdateGrainDepotInfo.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://grainplat", name = "args3", scope = SaveOrUpdateGrainDepotInfo.class)
    public JAXBElement<String> createSaveOrUpdateGrainDepotInfoArgs3(String value) {
        return new JAXBElement<String>(_SaveOrUpdateGrainDepotInfoArgs3_QNAME, String.class, SaveOrUpdateGrainDepotInfo.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://grainplat", name = "args4", scope = SaveOrUpdateGrainDepotInfo.class)
    public JAXBElement<String> createSaveOrUpdateGrainDepotInfoArgs4(String value) {
        return new JAXBElement<String>(_SaveOrUpdateGrainDepotInfoArgs4_QNAME, String.class, SaveOrUpdateGrainDepotInfo.class, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link String }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://grainplat", name = "args1", scope = SaveOrUpdateGrainDepotInfo.class)
    public JAXBElement<String> createSaveOrUpdateGrainDepotInfoArgs1(String value) {
        return new JAXBElement<String>(_SaveOrUpdateGrainDepotInfoArgs1_QNAME, String.class, SaveOrUpdateGrainDepotInfo.class, value);
    }

}
