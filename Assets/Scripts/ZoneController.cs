using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZoneController : MonoBehaviour
{
    public string Name;

    private Collider _coll;

    void Start()
    {
        _coll = GetComponent<Collider>();

        GameObject[] dossiers = GameObject.FindGameObjectsWithTag("Dossier");

        foreach (GameObject doss in dossiers)
        {
            if (_coll.bounds.Contains(doss.transform.position))
            {
                DossierController dossCtrl = doss.GetComponent<DossierController>();
                dossCtrl.Zone = Name + dossCtrl.Zone;
            }
        }
    }
}
