using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class EncounterController : MonoBehaviour
{
    public PlayerController Player;
    public NPCController NPC;

    private int _rounds;
    private Texture[] _stocks;
    Material[] _mats;

    void Start()
    {
        _rounds = Random.Range(5, 20);
        _stocks = Resources.LoadAll<Texture>("Stocks");

        NPC.Baloon.SetActive(true);
        Player.Baloon.SetActive(true);

        _mats = GameObject.FindGameObjectsWithTag("BaloonImage").Select(go => go.GetComponent<MeshRenderer>().material).ToArray(); ;
        ChangeImage();

        Player.Baloon.SetActive(false);
    }

    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            _rounds--;
            ChangeImage();

            NPC.Baloon.SetActive(!NPC.Baloon.activeInHierarchy);
            Player.Baloon.SetActive(!Player.Baloon.activeInHierarchy);
        }

        if (_rounds <= 0)
        {
            Destroy(this);

            NPC.Baloon.SetActive(false);
            Player.Baloon.SetActive(false);

            Player.RemoveStun();
            NPC.IgnorePlayer();
        }
    }

    void ChangeImage() {
        Texture _img = _stocks[Random.Range(0, _stocks.Length)];
        foreach (Material mat in _mats) mat.mainTexture = _img;
    }
}
