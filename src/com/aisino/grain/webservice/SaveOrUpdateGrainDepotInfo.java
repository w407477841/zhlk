
package com.aisino.grain.webservice;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElementRef;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for saveOrUpdateGrainDepotInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="saveOrUpdateGrainDepotInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="jsonData" type="{http://www.w3.org/2001/XMLSchema}base64Binary" minOccurs="0"/>
 *         &lt;element name="checkData" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="dataType" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="orgCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="entCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "saveOrUpdateGrainDepotInfo", propOrder = {
    "jsonData",
    "checkData",
    "dataType",
    "orgCode",
    "entCode"
})
public class SaveOrUpdateGrainDepotInfo {

    @XmlElementRef(name = "jsonData", type = JAXBElement.class, required = false)
    protected JAXBElement<byte[]> jsonData;
    protected String checkData;
    protected int dataType;
    protected String orgCode;
    protected String entCode;

    /**
     * Gets the value of the jsonData property.
     * 
     * @return
     *     possible object is
     *     {@link JAXBElement }{@code <}{@link byte[]}{@code >}
     *     
     */
    public JAXBElement<byte[]> getJsonData() {
        return jsonData;
    }

    /**
     * Sets the value of the jsonData property.
     * 
     * @param value
     *     allowed object is
     *     {@link JAXBElement }{@code <}{@link byte[]}{@code >}
     *     
     */
    public void setJsonData(JAXBElement<byte[]> value) {
        this.jsonData = value;
    }

    /**
     * Gets the value of the checkData property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCheckData() {
        return checkData;
    }

    /**
     * Sets the value of the checkData property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCheckData(String value) {
        this.checkData = value;
    }

    /**
     * Gets the value of the dataType property.
     * 
     */
    public int getDataType() {
        return dataType;
    }

    /**
     * Sets the value of the dataType property.
     * 
     */
    public void setDataType(int value) {
        this.dataType = value;
    }

    /**
     * Gets the value of the orgCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrgCode() {
        return orgCode;
    }

    /**
     * Sets the value of the orgCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrgCode(String value) {
        this.orgCode = value;
    }

    /**
     * Gets the value of the entCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEntCode() {
        return entCode;
    }

    /**
     * Sets the value of the entCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEntCode(String value) {
        this.entCode = value;
    }

}
