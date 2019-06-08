using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NPCController : MonoBehaviour
{
    public Transform Player;
    public GameObject[] Items;

    private bool _targetPlayer = false;

    void Start()
    {
        GameObject rndItem = Items[Random.Range(0, Items.Length)];
        GameObject newObj = Instantiate(rndItem, transform);
    }

    // Update is called once per frame
    void Update()
    {
        if (_targetPlayer)
        {
            Quaternion newRot = Quaternion.LookRotation(Player.position - transform.position);
            transform.rotation = Quaternion.Lerp(transform.rotation, newRot, 5 * Time.deltaTime);

            float dist = Vector3.Distance(transform.position, Player.position);
            float speed = .7f * Time.deltaTime;

            print(speed);

            transform.position = Vector3.Lerp(transform.position, Player.position, speed);

            if (dist < 2.5f)
            {
                print("Player Stunned");
            }
        }
    }

    private void OnTriggerEnter(Collider other) {
        if (other.gameObject.tag == "Player") _targetPlayer = true;
    }

    private void OnTriggerExit(Collider other) {
        if (other.gameObject.tag == "Player") _targetPlayer = false;
    }
}
