
package grainplat;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="args0" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="args1" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="args2" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="args3" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="args4" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "args0",
    "args1",
    "args2",
    "args3",
    "args4"
})
@XmlRootElement(name = "saveOrUpdateGrainDepotInfo")
public class SaveOrUpdateGrainDepotInfo {

    @XmlElementRef(name = "args0", namespace = "http://grainplat", type = JAXBElement.class, required = false)
    protected JAXBElement<String> args0;
    @XmlElementRef(name = "args1", namespace = "http://grainplat", type = JAXBElement.class, required = false)
    protected JAXBElement<String> args1;
    protected int args2;
    @XmlElementRef(name = "args3", namespace = "http://grainplat", type = JAXBElement.class, required = false)
    protected JAXBElement<String> args3;
    @XmlElementRef(name = "args4", namespace = "http://grainplat", type = JAXBElement.class, required = false)
    protected JAXBElement<String> args4;

    /**
     * Gets the value of the args0 property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getArgs0() {
        return args0;
    }

    /**
     * Sets the value of the args0 property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setArgs0(JAXBElement<String> value) {
        this.args0 = value;
    }

    /**
     * Gets the value of the args1 property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getArgs1() {
        return args1;
    }

    /**
     * Sets the value of the args1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setArgs1(JAXBElement<String> value) {
        this.args1 = value;
    }

    /**
     * Gets the value of the args2 property.
     * 
     */
    public int getArgs2() {
        return args2;
    }

    /**
     * Sets the value of the args2 property.
     * 
     */
    public void setArgs2(int value) {
        this.args2 = value;
    }

    /**
     * Gets the value of the args3 property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getArgs3() {
        return args3;
    }

    /**
     * Sets the value of the args3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setArgs3(JAXBElement<String> value) {
        this.args3 = value;
    }

    /**
     * Gets the value of the args4 property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public JAXBElement<String> getArgs4() {
        return args4;
    }

    /**
     * Sets the value of the args4 property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link String }{@code >}
     *     
     */
    public void setArgs4(JAXBElement<String> value) {
        this.args4 = value;
    }

}
